# In the Instances module's variables.tf or main.tf

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0c7217cdde317cfec"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

