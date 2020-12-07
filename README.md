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
| terraform | >= 0.12.19 |
| kubernetes | ~> 1.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of EKS cluster | `string` | n/a | yes |
| subnets | A list of subnets to place the EKS cluster and workers within. | `list(string)` | n/a | yes |
| vpc\_id | VPC where the cluster and workers will be deployed. | `string` | n/a | yes |
| attach\_worker\_autoscaling\_policy | Attach an autoscaling policy to the workers | `bool` | `false` | no |
| cloudwatch\_notification\_arn | ARN of SNS topic to send notifications to. Only used if `create_metric_filters` is true. | `string` | `null` | no |
| cluster\_access\_additional\_sgs | List of security groups to provide access to the internal cluster endpoint | `list(string)` | `[]` | no |
| cluster\_enabled\_log\_types | List of log types to send to CloudWatch | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| cluster\_endpoint\_private\_access | Whether or not to create private endpoint for cluster access | `bool` | `true` | no |
| cluster\_version | Version of EKS cluster (be careful about changing this on a running cluster) | `string` | `"1.15"` | no |
| create\_metric\_filters | Creates metric filters to look for kubernetes logs that indicate a problem. Must set `cloudwatch_notification_arn = true` if used. | `bool` | `false` | no |
| enable\_irsa | Enable IRSA (EKS IAM security OIDC provider) | `bool` | `true` | no |
| invalid\_bearer\_token\_threshold | Threshold for invalid bearer token alerting. This can indicate a misconfigured cluster but can fire false positives if set too low. | `number` | `10` | no |
| manage\_worker\_autoscaling\_policy | Whether or not the worker autoscaling policy should be managed by this module | `bool` | `false` | no |
| map\_roles | Additional IAM roles to add to the aws-auth configmap. | `list(any)` | `[]` | no |
| map\_users | Additional IAM users to add to the aws-auth configmap. | `list(any)` | `[]` | no |
| tags | Tags to apply to supported resources | `map(string)` | `{}` | no |
| worker\_groups | A list of maps defining worker group configurations to be defined using AWS Launch Configurations. See workers\_group\_defaults for valid keys. | `list(any)` | `[]` | no |
| worker\_groups\_launch\_template | A list of maps defining worker group configurations to be defined using AWS Launch Template. See workers\_group\_defaults for valid keys. | `list` | `[]` | no |
| workers\_additional\_policies | Additional IAM policies to attach (use ARNs) | `list(string)` | `[]` | no |
| workers\_group\_defaults | Override default values for target groups. See `workers_group_defaults_defaults` in local.tf for valid keys. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_log\_group\_name | Cluodwatch log group name, if logging enabled |
| cluster\_certificate\_authority\_data | Cluster CA Cert |
| cluster\_endpoint | Kubernetes API Endpoint URL |
| cluster\_iam\_role\_arn | IAM role name for the cluster |
| cluster\_id | EKS Cluster ID |
| cluster\_issuer\_url | OIDC Issuer URL (returns empty string unless IRSA is enabled) |
| cluster\_security\_group\_id | Security group protecting the cluster endpoint |
| cluster\_version | Kubernetes cluster version |
| worker\_iam\_role\_arn | IAM role attached to workers |
| worker\_iam\_role\_name | IAM role attached to workers |
| worker\_security\_group\_id | Security group ID attached to the EKS workers. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
