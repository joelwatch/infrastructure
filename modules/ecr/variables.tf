variable "repository_names" {
  type        = list(string)
  description = "List of ECR repository names to create"
  default     = []
}

variable "image_tag_mutability" {
  type        = string
  description = "Tag mutability setting for repositories (MUTABLE or IMMUTABLE)"
  default     = "MUTABLE"
}

variable "scan_on_push" {
  type        = bool
  description = "Enable image scanning on push"
  default     = true
}

variable "encryption_type" {
  type        = string
  description = "Encryption type (AES256 or KMS)"
  default     = "AES256"
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of KMS key to use when encryption_type is KMS"
  default     = null
}

variable "lifecycle_policies" {
  type = map(string)
  description = "Map of repository names to JSON lifecycle policy documents"
  default = {}
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default     = {}
}