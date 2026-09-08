locals {
  name = "${var.project}-${var.environment}"
  tags = { Project=var.project, Environment=var.environment, ManagedBy="Terraform"}
}
module "network" {
    source = "../../modules/network"
    name = local.name
    vpc_cidr = var.vpc_cidr
    azs = var.azs
    private_subnet = var.private_subnet
    public_subnet = var.public_subnet
    tags = local.tags
}
module "eks" {
  source = "../../modules/eks"
  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version
  vpc_id = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids
  instance_type = var.instance_types
  min_size = var.node_min
  desired_size = var.node_desired
  max_size = var.node_max
  tags = local.tags
}
module "ecr" {
  source = "../../modules/ecr"
  repositories = ["${local.name}-catalog-serice", "${local.name}-order-service"]
  tags = local.tags
}
module "data" {
  source = "../../modules/data"
  table_names = ["${local.name}-orders"]
  tags = local.tags
}
module "order_irsa"{
  source = "../../modules/irsa"
  name = "${local.name}-order-service"
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider = module.eks.oidc_provider
  namespace = "megamart"
  service_account_name = "order-service"
  table_arn = module.data.table_arn
  tags = local.tags
}
module "github_oidc" {
  source = "../../modules/github_oidc"
  name = "${local.name}-github-actions"
  github_org = var.github_org
  github_repo = var.github_repo
  ecr_repository_arns = values (module.ecr.repository_arns)
  tags = locals.tags
}
module "addons" {
  source = "../../modules/addons"
  cluster_name = module.eks.cluster_name
  region = var.region
  vpc_id = module.network.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider = module.eks.oidc_provider
  depends_on = [ module.eks ]
}