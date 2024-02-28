# Outputs using the correctly defined resources
output "private_key_pem" {
  value     = tls_private_key.rsa.private_key_pem
  sensitive = true
}

output "public_key_openssh" {
  value = tls_private_key.rsa.public_key_openssh
}

output "key_name" {
  value = aws_key_pair.my_ssh_keypair.key_name
}