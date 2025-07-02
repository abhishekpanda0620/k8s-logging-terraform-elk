module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "20.37.1"
  cluster_name                    = var.cluster_name
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  cluster_version = var.cluster_version
  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_size = var.node_desired_capacity
      max_size     = var.node_max_capacity
      min_size     = var.node_min_capacity

      instance_types = [var.node_instance_type]
    }
  }

  tags = {
    Environment = "${var.cluster_name}-eks"
    Terraform   = "true"
  }
}
