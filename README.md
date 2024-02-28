# Terraform-Modules
Terraform Module Creation

### Structure of the each Module.

![Modules-Structure](https://github.com/hardikkwatra/Terraform-Modules/assets/78718601/d0c4d93e-b21a-4b55-a3b1-136c2ee41efb)


### Each Module Detail :

### 1. VPC Creation Module:

**Purpose:** 
This module sets up a Virtual Private Cloud (VPC) in AWS, which is a logically isolated section of the AWS Cloud where you can launch AWS resources in a defined virtual network.

**Implementation:**
- **main.tf:** 
  - Defines an AWS VPC resource specifying the CIDR block that accommodates at least 32,000 IPs.
  - Creates both public and private subnets across three availability zones within the VPC.
- **variables.tf:**
  - Contains variables for VPC CIDR block, public subnet CIDR block, private subnet CIDR block, availability zones, and VPC name.
- **output.tf:**
  - Outputs the VPC ID for reference in other modules.

### 2. SSH Keypair Module:

**Purpose:** 
This module generates an SSH keypair which can be used to securely connect to instances within the VPC.

**Implementation:**
- **main.tf:**
  - Uses Terraform `tls_private_key` resource to generate a private RSA key.
- **variables.tf:** No variables needed.
- **output.tf:**
  - Outputs the private and public key values for later use.

### 3. Instance Creation Module:

**Purpose:** 
This module creates EC2 instances within the VPC - two private instances and one public instance acting as a jump host.

**Implementation:**
- **main.tf:**
  - Defines AWS EC2 instances in both public and private subnets.
  - Sets up security groups for SSH access and any additional rules required.
- **variables.tf:**
  - Contains variables for security group configurations such as SSH port, additional rules, etc.
- **output.tf:** No outputs needed.

### 4. NAT and Internet Gateway Module:

**Purpose:** 
This module sets up a NAT Gateway and Internet Gateway to allow instances in private subnets to access the internet.

**Implementation:**
- **main.tf:**
  - Creates an AWS NAT Gateway and associates it with the public subnet.
  - Sets up an Internet Gateway and attaches it to the VPC.
- **variables.tf:** No variables needed.
- **output.tf:** No outputs needed.

### 5. Nginx and Docker Setup Module:

**Purpose:** 
This module installs Nginx and Docker on all private instances to serve web content and facilitate containerized applications.

**Implementation:**
- Utilizes Ansible for configuration management to install Nginx and Docker on private instances.
- Terraform will provision EC2 instances and then trigger Ansible for configuration management.

### 6. Load Balancer Module:

**Purpose:** 
This module sets up a private Application Load Balancer (ALB) and attaches private EC2 instances to it for load distribution.

**Implementation:**
- **main.tf:**
  - Defines an AWS ALB resource and associated listener and target group.
  - Sets up security groups for ALB.
- **variables.tf:** 
  - Contains variables for ALB configurations such as listener port, target group port, etc.
- **output.tf:** No outputs needed.

### 7. API Gateway Module:

**Purpose:** 
This module sets up an API Gateway to provide access to the ALB and display the NGINX page.

**Implementation:**
- **main.tf:**
  - Configures AWS API Gateway with appropriate routes to the ALB.
  - Utilizes Lambda functions or HTTP integrations to connect to the ALB.
- **variables.tf:** 
  - Contains variables for API Gateway configurations such as route definitions, Lambda functions, etc.
- **output.tf:** No outputs needed.





