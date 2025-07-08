variable "namespace_kyc" {
  description = "Namespace for kyc-dev"
  type        = string
  default     = "kyc-dev"
}

variable "docker_username" {
  description = "Docker registry username (e.g., for GHCR)"
  type        = string
  default     = "vito-makhatadze"  # Replace with your GHCR username
  sensitive   = true
}

variable "docker_password" {
  description = "Docker registry password (e.g., for GHCR)"
  type        = string
  default     = "secret"  # Replace with your GHCR token or password
  sensitive   = true
}