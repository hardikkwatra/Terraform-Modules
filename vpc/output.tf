# output.tf
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "public_subnet_id_2" {
  value = aws_subnet.public_2.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

