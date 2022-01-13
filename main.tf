# Sabotaging the local provider because it can't actually talk to the right cluster on provisioning operations
terraform {
  required_version = ">= 0.12.19"
}

provider "kubernetes" {
  host             = "http://localhost:9999"
}

module "eks" {
  source                           = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v8.0.0"
  attach_worker_autoscaling_policy = var.attach_worker_autoscaling_policy
  cluster_enabled_log_types        = var.cluster_enabled_log_types
  cluster_endpoint_private_access  = var.cluster_endpoint_private_access
  cluster_name                     = var.cluster_name
  cluster_version                  = var.cluster_version
  enable_irsa                      = var.enable_irsa
  manage_aws_auth                  = false # this is dangerous
  manage_worker_autoscaling_policy = var.manage_worker_autoscaling_policy
  map_users                        = var.map_users
  map_roles                        = var.map_roles
  subnets                          = var.subnets
  vpc_id                           = var.vpc_id
  worker_groups                    = var.worker_groups
  workers_additional_policies      = var.workers_additional_policies
  worker_groups_launch_template    = var.worker_groups_launch_template
  workers_group_defaults = merge(
    {
      "kubelet_extra_args" = "--kube-reserved cpu=250m,memory=1Gi,ephemeral-storage=1Gi --system-reserved cpu=250m,memory=0.2Gi,ephemeral-storage=1Gi"
      "pre_userdata"       = templatefile("${path.module}/workerNode.sh.tpl", { disable_imds = var.disable_imds })
    },
    var.workers_group_defaults
  )

  tags = var.tags

}

resource "aws_security_group_rule" "cluster_https_cluster_ingress" {
  count                    = length(var.cluster_access_additional_sgs)
  description              = "Allow other instances to communicate with the EKS cluster API."
  protocol                 = "tcp"
  security_group_id        = module.eks.cluster_security_group_id
  source_security_group_id = var.cluster_access_additional_sgs[count.index]
  from_port                = 443
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_cloudwatch_log_metric_filter" "invalid_bearer_token" {
  count          = var.create_metric_filters ? 1 : 0
  name           = "${var.cluster_name}-invalid-bearer-token"
  pattern        = "\"[invalid bearer token\""
  log_group_name = module.eks.cloudwatch_log_group_name[0]

  metric_transformation {
    name          = "${var.cluster_name}-InvalidBearerToken"
    namespace     = "eks"
    value         = 1
    default_value = 0
  }
}

resource "aws_cloudwatch_metric_alarm" "invalid_bearer_token" {
  count               = var.create_metric_filters ? 1 : 0
  alarm_actions       = [var.cloudwatch_notification_arn]
  alarm_name          = "${var.cluster_name}-invalid-bearer-token"
  alarm_description   = "Invalid bearer token errors, worker nodes may not be communicating with cluster. Check aws-auth config map."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "${var.cluster_name}-InvalidBearerToken"
  namespace           = "eks"
  period              = 60
  statistic           = "Sum"
  threshold           = var.invalid_bearer_token_threshold
}
