# Define VPC module
module "vpc" {
  source = "C:/Terraform-Modules/vpc"
}

# Define SSH keypair module
module "ssh_keypair" {
  source = "C:/Terraform-Modules/SSH Keypair"
  # Any additional configuration for the SSH keypair module can be added here
}

# Define EC2 Instances in the main configuration
resource "aws_instance" "public_instance" {
  count           = 1
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = module.vpc.public_subnet_id
  key_name        = module.ssh_keypair.key_name
  security_groups = [aws_security_group.public_access.id]

  tags = {
    Name = "PublicInstance-${count.index}"
  }
}

resource "aws_instance" "private_instance" {
  count           = 2
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = module.vpc.private_subnet_id
  key_name        = module.ssh_keypair.key_name
  security_groups = [aws_security_group.private_access.id]


  tags = {
    Name = "PrivateInstance-${count.index}"
  }
}

# Define Security Groups in the main configuration
resource "aws_security_group" "public_access" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PublicAccessSG"
  }
}

resource "aws_security_group" "private_access" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "PrivateAccessSG"
  }
}