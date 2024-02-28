# In the alb module's variables.tf or main.tf

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet where the ALB will be deployed"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet where the ALB will be deployed"
  type        = string
}

variable "public_instance_ips" {
  description = "List of public IP addresses of instances for ALB targets"
  type        = list(string)
}

variable "private_instance_ips" {
  description = "List of private IP addresses of instances for ALB targets"
  type        = list(string)
}
