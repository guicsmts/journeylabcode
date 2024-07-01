// outputs.tf
output "cluster_id" {
  description = "ID do Cluster EKS"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint do Cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "ID do Security Group do Cluster EKS"
  value       = module.eks.cluster_security_group_id
}

output "cluster_version" {
  description = "Versão do Cluster EKS"
  value       = module.eks.cluster_version
}
