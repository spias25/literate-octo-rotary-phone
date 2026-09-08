module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name = var.cluster_name
  kubernetes_version = var.kubernetes_version
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
    vpc_id = var.vpc_id
    subnet_ids = var.private_subnet_ids
    enable_irsa = true
    addons = { coredns = {most_recent = true}, kube-proxy = {most_recent = true}, vpc-cni = {most_recent = true}}
    eks_managed_node_groups = {
        general = {
            instance_types = var.instance_type
            min_size = var.node_min_size
            desired_size = var.node_desired_size
            max_size = var.node_max_size
            capacity_type = "ON_DEMAND"
            tags = {
                k8s.io/cluster-autoscaler/enabled = "true"
                k8s.io/cluster-autoscaler/${var.cluster_name} = "owned"
            }
        }
    }
}
output "cluster_name" {
  value = module.eks.cluster_name
}
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}
output "oidc_provider" {
  value = module.eks.cluster_oidc
}
output "oidc_provider_arn" {
  value = module.eks.cluster_oidc_arn
}
