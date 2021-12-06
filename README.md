# terraform-aws-eks-cluster

[![tflint](https://github.com/rhythmictech/terraform-aws-eks-cluster/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-eks-cluster/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/terraform-aws-eks-cluster/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-eks-cluster/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/terraform-aws-eks-cluster/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-eks-cluster/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/terraform-aws-eks-cluster/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-eks-cluster/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/terraform-aws-eks-cluster/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/terraform-aws-eks-cluster/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

Create and manage an EKS cluster. This module is primarily a wrapper around the official EKS module, which makes a few opinionated decisions to make life easier for most use cases.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.19 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | git::https://github.com/terraform-aws-modules/terraform-aws-eks.git | v8.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_metric_filter.invalid_bearer_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.invalid_bearer_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_security_group_rule.cluster_https_cluster_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_worker_autoscaling_policy"></a> [attach\_worker\_autoscaling\_policy](#input\_attach\_worker\_autoscaling\_policy) | Attach an autoscaling policy to the workers | `bool` | `false` | no |
| <a name="input_cloudwatch_notification_arn"></a> [cloudwatch\_notification\_arn](#input\_cloudwatch\_notification\_arn) | ARN of SNS topic to send notifications to. Only used if `create_metric_filters` is true. | `string` | `null` | no |
| <a name="input_cluster_access_additional_sgs"></a> [cluster\_access\_additional\_sgs](#input\_cluster\_access\_additional\_sgs) | List of security groups to provide access to the internal cluster endpoint | `list(string)` | `[]` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | List of log types to send to CloudWatch | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Whether or not to create private endpoint for cluster access | `bool` | `true` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of EKS cluster (be careful about changing this on a running cluster) | `string` | `"1.15"` | no |
| <a name="input_create_metric_filters"></a> [create\_metric\_filters](#input\_create\_metric\_filters) | Creates metric filters to look for kubernetes logs that indicate a problem. Must set `cloudwatch_notification_arn = true` if used. | `bool` | `false` | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Enable IRSA (EKS IAM security OIDC provider) | `bool` | `true` | no |
| <a name="input_invalid_bearer_token_threshold"></a> [invalid\_bearer\_token\_threshold](#input\_invalid\_bearer\_token\_threshold) | Threshold for invalid bearer token alerting. This can indicate a misconfigured cluster but can fire false positives if set too low. | `number` | `10` | no |
| <a name="input_manage_worker_autoscaling_policy"></a> [manage\_worker\_autoscaling\_policy](#input\_manage\_worker\_autoscaling\_policy) | Whether or not the worker autoscaling policy should be managed by this module | `bool` | `false` | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. | `list(any)` | `[]` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | `list(any)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | A list of subnets to place the EKS cluster and workers within. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to supported resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC where the cluster and workers will be deployed. | `string` | n/a | yes |
| <a name="input_worker_groups"></a> [worker\_groups](#input\_worker\_groups) | A list of maps defining worker group configurations to be defined using AWS Launch Configurations. See workers\_group\_defaults for valid keys. | `list(any)` | `[]` | no |
| <a name="input_worker_groups_launch_template"></a> [worker\_groups\_launch\_template](#input\_worker\_groups\_launch\_template) | A list of maps defining worker group configurations to be defined using AWS Launch Template. See workers\_group\_defaults for valid keys. | `list` | `[]` | no |
| <a name="input_workers_additional_policies"></a> [workers\_additional\_policies](#input\_workers\_additional\_policies) | Additional IAM policies to attach (use ARNs) | `list(string)` | `[]` | no |
| <a name="input_workers_group_defaults"></a> [workers\_group\_defaults](#input\_workers\_group\_defaults) | Override default values for target groups. See `workers_group_defaults_defaults` in local.tf for valid keys. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Cluodwatch log group name, if logging enabled |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Cluster CA Cert |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Kubernetes API Endpoint URL |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role name for the cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | EKS Cluster ID |
| <a name="output_cluster_issuer_url"></a> [cluster\_issuer\_url](#output\_cluster\_issuer\_url) | OIDC Issuer URL (returns empty string unless IRSA is enabled) |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Security group protecting the cluster endpoint |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | Kubernetes cluster version |
| <a name="output_worker_iam_role_arn"></a> [worker\_iam\_role\_arn](#output\_worker\_iam\_role\_arn) | IAM role attached to workers |
| <a name="output_worker_iam_role_name"></a> [worker\_iam\_role\_name](#output\_worker\_iam\_role\_name) | IAM role attached to workers |
| <a name="output_worker_security_group_id"></a> [worker\_security\_group\_id](#output\_worker\_security\_group\_id) | Security group ID attached to the EKS workers. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
