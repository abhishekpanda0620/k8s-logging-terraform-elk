terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.37.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # Optionally specify profile if using named AWS CLI profiles
  # profile = "default"
}

module "vpc" {
    source              = "./modules/vpc"
    cidr_block          = "10.0.0.0/16"
    public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
    availability_zones  = ["us-east-1a", "us-east-1b"]
    vpc_name            = "eks-vpc"
}


output "vpc_id" {
  value = module.vpc.vpc_id
  
}

module "eks" {
  source                = "./modules/eks"
  subnet_ids            = module.vpc.private_subnet_ids
  vpc_id                = module.vpc.vpc_id
}
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
  depends_on = [ module.eks ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
  depends_on = [ module.eks ]
}
