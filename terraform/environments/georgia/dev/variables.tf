variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "georgia"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}