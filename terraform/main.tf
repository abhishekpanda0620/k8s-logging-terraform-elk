terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
     kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.37.1"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  # Optionally specify profile if using named AWS CLI profiles
  # profile = "default"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}
