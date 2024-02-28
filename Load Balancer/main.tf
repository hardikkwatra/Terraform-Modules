# Module reference for VPC
module "vpc" {
  source         = "C:/Terraform-Modules/vpc"
  vpc_cidr_block = "10.0.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}
module "instances" {
  source = "C:/Terraform-Modules/Instances"
}


# Define ALB security group
resource "aws_security_group" "alb_sg" {
  vpc_id = module.vpc.vpc_id

  // Define inbound rules for ALB
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
    Name = "ALBSecurityGroup"
  }
}

# Define ALB
resource "aws_lb" "alb" {
  name               = "example-alb"
  internal           = true # Set to 'false' if external access is needed
  load_balancer_type = "application"

  # Use subnet_mapping for high availability
  subnet_mapping {
    subnet_id = module.vpc.public_subnet_id # Replace with actual ID
  }

  subnet_mapping {
    subnet_id = module.vpc.public_subnet_id_2 # Replace with actual ID
  }

  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Name = "ALB"
  }
}

# Define ALB listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}

# Define ALB target group
resource "aws_lb_target_group" "target_group" {
  name     = "example-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "target_attachment" {
  count            = length(var.private_instance_ips)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.private_instance_ips[count.index]
}
