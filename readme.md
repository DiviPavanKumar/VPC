# Roboshop VPC Terraform Setup

This Terraform configuration sets up a basic AWS Virtual Private Cloud (VPC) architecture for the Roboshop project. It includes a public and private subnet, an Internet Gateway, and appropriate route tables with subnet associations.

---

## 📦 Resources Created

### 1. VPC
- **CIDR Block**: `10.0.0.0/16`
- This creates the main virtual network to host all AWS resources.
- **Tag**: `Name = Roboshop_VPC`

### 2. Public Subnet
- **CIDR Block**: `10.0.1.0/24`
- Attached to the VPC.
- **Tag**: `Name = Public_Subnet`

### 3. Private Subnet
- **CIDR Block**: `10.0.2.0/24`
- Also attached to the same VPC.
- **Tag**: `Name = Private_Subnet`

### 4. Internet Gateway (IGW)
- Allows internet access for resources in the public subnet.
- **Tag**: `Name = Internet_Gateway_Roboshop`

### 5. Public Route Table
- Associated with the public subnet.
- Routes `0.0.0.0/0` (all internet traffic) to the Internet Gateway.
- **Tag**: `Name = Public_Route`

### 6. Private Route Table
- Associated with the private subnet.
- No route to the internet is configured (isolated).
- **Tag**: `Name = Private_Route`

### 7. Route Table Associations
- Public subnet associated with public route table.
- Private subnet associated with private route table.

---

## 🛠 How to Use

1. Initialize the project:
   $terraform init

2. Review the plan:
   $terraform plan

3. Apply the configuration:
   $terraform apply

🔐 Notes
-> Public subnet has internet access via IGW.
-> Private subnet is fully internal.
-> Ideal for workloads where you want to isolate back-end components.

📁 File Structure
    .
    ├── main.tf           # Contains all the Terraform resource definitions
    ├── README.md         # Project documentation

👤 Author
- Pavan Kumar Divi
- Environment: Development
- Project: Roboshop
- Provisioned using: Terraform