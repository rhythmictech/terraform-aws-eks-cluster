
variable "additional_security_group_ids" {
  type    = list(string)
  default = []
}

variable "attach_worker_autoscaling_policy" {
  type    = bool
  default = false
}

variable "cloudwatch_notification_arn" {
  default     = ""
  description = "ARN of SNS topic to send notifications to. Only used if create_metric_filters is true."
  type        = string
}

variable "cluster_access_additional_sgs" {
  type        = list(string)
  default     = []
  description = "List of security groups to provide access to the internal cluster endpoint"
}

variable "cluster_enabled_log_types" {
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "List of log types to send to CloudWatch"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = true
  description = "Whether or not to create private endpoint for cluster access"
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.13"
}

variable "create_metric_filters" {
  default     = false
  description = "Creates metric filters to look for kubernetes logs that indicate a problem. Must set cloudwatch_notification_arn = true if used."
  type        = bool
}

variable "enable_irsa" {
  type        = bool
  default     = true
  description = "Enable IRSA (EKS IAM security OIDC provider)"
}

variable "manage_worker_autoscaling_policy" {
  type    = bool
  default = false
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = list
  default     = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type        = list
  default     = []
}

variable "subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
  type        = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}


variable "vpc_id" {
  description = "VPC where the cluster and workers will be deployed."
}

variable "worker_groups" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Configurations. See workers_group_defaults for valid keys."
  type        = any

  default = []
}

variable "worker_groups_launch_template" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Template. See workers_group_defaults for valid keys."
  type        = any

  default = []
}
variable "workers_group_defaults" {
  description = "Override default values for target groups. See workers_group_defaults_defaults in local.tf for valid keys."
  type        = any
  default = {
  }
}
