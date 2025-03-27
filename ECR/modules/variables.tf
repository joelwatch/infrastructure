variable "project_name" {
  type = string
}

variable "repository_type" {
  type = list(string)
}

variable "repository_count" {
  type = number
}

variable "environment" {
  type = string
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "Define the mutability of the image (MUTABLE) or not (IMMUTABLE)"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "La valeur doit être soit 'MUTABLE' soit 'IMMUTABLE'."
  }
}