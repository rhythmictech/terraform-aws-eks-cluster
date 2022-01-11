variable "attach_worker_autoscaling_policy" {
  default     = false
  description = "Attach an autoscaling policy to the workers"
  type        = bool
}

variable "cloudwatch_notification_arn" {
  default     = null
  description = "ARN of SNS topic to send notifications to. Only used if `create_metric_filters` is true."
  type        = string
}

variable "cluster_access_additional_sgs" {
  default     = []
  description = "List of security groups to provide access to the internal cluster endpoint"
  type        = list(string)
}

variable "cluster_enabled_log_types" {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "List of log types to send to CloudWatch"
  type        = list(string)
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = true
  description = "Whether or not to create private endpoint for cluster access"
}

variable "cluster_name" {
  description = "Name of EKS cluster"
  type        = string
}

variable "cluster_version" {
  default     = "1.15"
  description = "Version of EKS cluster (be careful about changing this on a running cluster)"
  type        = string
}

variable "create_metric_filters" {
  default     = false
  description = "Creates metric filters to look for kubernetes logs that indicate a problem. Must set `cloudwatch_notification_arn = true` if used."
  type        = bool
}

variable "disable_imds" {
  default     = false
  description = "Disable IMDS (EC2 metadata url) for pods, see https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html"
  type        = bool
}

variable "enable_irsa" {
  default     = true
  description = "Enable IRSA (EKS IAM security OIDC provider)"
  type        = bool
}

variable "invalid_bearer_token_threshold" {
  default     = 10
  description = "Threshold for invalid bearer token alerting. This can indicate a misconfigured cluster but can fire false positives if set too low."
  type        = number
}

variable "manage_worker_autoscaling_policy" {
  default     = false
  description = "Whether or not the worker autoscaling policy should be managed by this module"
  type        = bool
}

variable "map_users" {
  default     = []
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = list(any)
}

variable "map_roles" {
  default     = []
  description = "Additional IAM roles to add to the aws-auth configmap."
  type        = list(any)
}

variable "subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
  type        = list(string)
}

variable "tags" {
  default     = {}
  description = "Tags to apply to supported resources"
  type        = map(string)
}


variable "vpc_id" {
  description = "VPC where the cluster and workers will be deployed."
  type        = string
}

variable "workers_additional_policies" {
  default     = []
  description = "Additional IAM policies to attach (use ARNs)"
  type        = list(string)
}

variable "worker_groups" {
  default     = []
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Configurations. See workers_group_defaults for valid keys."
  type        = list(any)
}

# Typing this causes Terraform to crash https://github.com/hashicorp/terraform/issues/21588
# tflint-ignore: terraform_typed_variables
variable "worker_groups_launch_template" {
  default     = []
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Template. See workers_group_defaults for valid keys."
}

# Typing this causes Terraform to crash https://github.com/hashicorp/terraform/issues/21588
# tflint-ignore: terraform_typed_variables
variable "workers_group_defaults" {
  default     = {}
  description = "Override default values for target groups. See `workers_group_defaults_defaults` in local.tf for valid keys."
}
