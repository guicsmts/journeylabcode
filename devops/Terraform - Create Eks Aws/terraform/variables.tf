// variables.tf
variable "region" {
  description = "Região AWS"
  type        = string
  default     = "us-west-1"
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs_public" {
  description = "CIDR das Subnets Públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_cidrs_private" {
  description = "CIDR das Subnets Privadas"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
