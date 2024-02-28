# variables.tf
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_block_2" {
  description = "CIDR block for the second public subnet"
  default     = "10.0.2.0/24"
}


variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  default     = "10.0.3.0/24"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
