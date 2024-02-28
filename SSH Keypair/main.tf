# Define the TLS private key (from previous corrected code)
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Store the private key locally (optional) (from previous corrected code)
resource "local_file" "private_key_pem" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "private_key.pem"
}

# Create the AWS key pair referencing the public key (from previous corrected code)
resource "aws_key_pair" "my_ssh_keypair" {
  key_name   = "my_ssh_key" # Replace with your desired key name
  public_key = tls_private_key.rsa.public_key_openssh
}