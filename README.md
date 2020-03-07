# terraform-aws-eks-cluster

Create and manage an EKS cluster

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional\_security\_group\_ids |  | list(string) | `[]` | no |
| attach\_worker\_autoscaling\_policy |  | bool | `"false"` | no |
| cloudwatch\_notification\_arn | ARN of SNS topic to send notifications to. Only used if create\_metric\_filters is true. | string | `""` | no |
| cluster\_access\_additional\_sgs | List of security groups to provide access to the internal cluster endpoint | list(string) | `[]` | no |
| cluster\_enabled\_log\_types | List of log types to send to CloudWatch | list(string) | `[ "api", "audit", "authenticator", "controllerManager", "scheduler" ]` | no |
| cluster\_endpoint\_private\_access | Whether or not to create private endpoint for cluster access | bool | `"true"` | no |
| cluster\_name |  | string | n/a | yes |
| cluster\_version |  | string | `"1.13"` | no |
| create\_metric\_filters | Creates metric filters to look for kubernetes logs that indicate a problem. Must set cloudwatch\_notification\_arn = true if used. | bool | `"false"` | no |
| enable\_irsa | Enable IRSA \(EKS IAM security OIDC provider\) | bool | `"true"` | no |
| manage\_worker\_autoscaling\_policy |  | bool | `"false"` | no |
| map\_roles | Additional IAM roles to add to the aws-auth configmap. | list | `[]` | no |
| map\_users | Additional IAM users to add to the aws-auth configmap. | list | `[]` | no |
| subnets | A list of subnets to place the EKS cluster and workers within. | list(string) | n/a | yes |
| tags |  | map(string) | `{}` | no |
| vpc\_id | VPC where the cluster and workers will be deployed. | string | n/a | yes |
| worker\_groups | A list of maps defining worker group configurations to be defined using AWS Launch Configurations. See workers\_group\_defaults for valid keys. | any | `[]` | no |
| worker\_groups\_launch\_template | A list of maps defining worker group configurations to be defined using AWS Launch Template. See workers\_group\_defaults for valid keys. | any | `[]` | no |
| workers\_group\_defaults | Override default values for target groups. See workers\_group\_defaults\_defaults in local.tf for valid keys. | any | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_log\_group\_name | Cluodwatch log group name, if logging enabled |
| cluster\_certificate\_authority\_data | Cluster CA Cert |
| cluster\_endpoint | Kubernetes API Endpoint URL |
| cluster\_id | EKS Cluster ID |
| cluster\_issuer\_url | OIDC Issuer URL \(returns empty string unless IRSA is enabled\) |
| cluster\_security\_group\_id | Security group protecting the cluster endpoint |
| cluster\_version | Kubernetes cluster version |
| worker\_iam\_role\_arn |  |
| worker\_iam\_role\_name |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
