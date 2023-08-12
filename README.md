---
# Terraform Configuration for Azure Deployment

This Terraform configuration deploys resources in Azure, including a Virtual Network, Subnet, Public IP, Network Interface, and a Virtual Machine.

## Resources Deployed

- **Virtual Network**: A virtual network named `ExampleInc` with an address space of `10.0.0.0/16` located in `Central US`.
  
- **Subnet**: A subnet within the virtual network with an address prefix of `10.0.1.0/24`.

- **Public IP**: A dynamic public IP address for the virtual machine.

- **Network Interface**: A network interface that connects the virtual machine to the virtual network and associates it with the public IP.

- **Virtual Machine**: An Ubuntu 18.04-LTS virtual machine. The VM's computer name, admin username, and admin password are provided as variables during the `terraform apply` command.

## Deployment

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Apply the Terraform configuration:
   ```bash
   terraform apply -var="resource_group_name=YOUR_RESOURCE_GROUP_NAME" -var="vm_computer_name=YOUR_VM_NAME" -var="vm_admin_username=YOUR_ADMIN_USERNAME" -var="vm_admin_password=YOUR_SECURE_PASSWORD"
   ```

Replace the placeholders (`YOUR_RESOURCE_GROUP_NAME`, `YOUR_VM_NAME`, `YOUR_ADMIN_USERNAME`, `YOUR_SECURE_PASSWORD`) with appropriate values.

---
