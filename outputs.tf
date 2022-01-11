output "cloudwatch_log_group_name" {
  description = "Cluodwatch log group name, if logging enabled"
  value       = module.eks.cloudwatch_log_group_name
}

output "cluster_certificate_authority_data" {
  description = "Cluster CA Cert"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Kubernetes API Endpoint URL"
  value       = module.eks.cluster_endpoint
}

output "cluster_iam_role_arn" {
  description = "IAM role name for the cluster"
  value       = module.eks.cluster_iam_role_arn
}

output "cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_issuer_url" {
  description = "OIDC Issuer URL (returns empty string unless IRSA is enabled)"
  value       = var.enable_irsa ? module.eks.cluster_oidc_issuer_url : ""
}

output "cluster_issuer_arn" {
  description = "OIDC Issuer ARN (returns empty string unless IRSA is enabled)"
  value       = var.enable_irsa ? module.eks.oidc_provider_arn : ""
}

output "cluster_security_group_id" {
  description = "Security group protecting the cluster endpoint"
  value       = module.eks.cluster_security_group_id
}

output "cluster_version" {
  description = "Kubernetes cluster version"
  value       = module.eks.cluster_version
}

output "worker_iam_role_arn" {
  description = "IAM role attached to workers"
  value       = module.eks.worker_iam_role_arn
}

output "worker_iam_role_name" {
  description = "IAM role attached to workers"
  value       = module.eks.worker_iam_role_name
}
output "worker_security_group_id" {
  description = "Security group ID attached to the EKS workers."
  value       = module.eks.worker_security_group_id
}
