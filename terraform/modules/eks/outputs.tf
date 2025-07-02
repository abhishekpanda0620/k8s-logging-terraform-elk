
output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_certificate_authority_data" {
  description = "The base64 encoded CA certificate for the EKS cluster."
  value       = module.eks.cluster_certificate_authority_data
}
output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster."
  value       = module.eks.cluster_endpoint
}