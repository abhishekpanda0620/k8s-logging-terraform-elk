variable "backend_s3_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
  default     = "terraform-state-bucket"
}

variable "backend_s3_key" {
  description = "S3 key for Terraform state"
  type        = string
  default     = "terraform.tfstate"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "docker_image" {
  description = "Docker image for the application"
  type        = string
  default     = "DEFAULT_DOCKER_IMAGE" 
  
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "user-crud-service"
  
}