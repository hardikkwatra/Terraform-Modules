# Importing necessary resources from other modules
module "vpc" {
  source = "C:/Terraform-Modules/vpc"
}

module "ssh_keypair" {
  source = "C:/Terraform-Modules/SSH Keypair" # Changed source path to avoid spaces
}

module "instances" {
  source        = "C:/Terraform-Modules/Instances"
  instance_type = "t2.micro" # Provide a valid instance type here
}


module "alb" {
  source               = "C:/Terraform-Modules/Load Balancer"
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  private_subnet_id    = module.vpc.private_subnet_id
  public_instance_ips  = module.instances.public_instance_ips
  private_instance_ips = module.instances.private_instance_ips
}


# Defining API Gateway resources
resource "aws_api_gateway_rest_api" "example" {
  name        = "MyAwesomeAPI"
  description = var.api_description
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id             = aws_api_gateway_rest_api.example.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${module.alb.alb_dns_name}/{proxy}"
}

resource "aws_api_gateway_deployment" "example" {
  depends_on  = [aws_api_gateway_integration.proxy]
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = var.stage_name
}