# Azure Infrastructure Deployment with Terraform

This repository demonstrates how to deploy a secure, reusable, and maintainable Azure infrastructure using Terraform. It features a reusable module for deploying an Azure Virtual Network (VNET) with subnets and automatically provisioned Network Security Groups (NSGs), along with a sample development environment configuration.

## Repository Structure

```
.
├── modules
│   └── vnet
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       ├── versions.tf
│       └── README.md
├── environments
│   └── dev
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfvars
│       ├── variables.tf
│       └── versions.tf
└── .github
    └── workflows
        └── terraform.yml
```

## Features

- **Modular Design**: Reusable VNET module for consistent network deployments
- **Environment-based Configuration**: Separate configurations for different environments (dev, test, prod)
- **Automated CI/CD**: GitHub Actions workflow for infrastructure validation and deployment
- **Security Best Practices**: Secure defaults for all resources
- **Resource Tagging**: Comprehensive labeling for improved resource management

## Environment Setup

The repository includes an example for a development environment that:

- Uses the VNET module to create a secure virtual network with subnets
- Provisions additional resources (e.g., a Storage Account and a Linux Virtual Machine) with secure defaults
- Labels resources by environment and region for improved tracking

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription with appropriate permissions

### Deployment Steps

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/atunero/terraform-azure-infrastructure.git
   cd terraform-azure-infrastructure/environments/dev
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Validate the Configuration:**
   ```bash
   terraform validate
   ```

4. **Show deployment plan:**
   ```bash
   terraform show terraform-plan
   ```

5. **Apply the Configuration:**
   ```bash
   terraform apply "terraform-plan"
   ```

6. **Clean Up (Optional):**
   ```bash
   terraform destroy
   ```

## CI/CD Pipeline

A GitHub Actions pipeline is set up to automate deployment. The workflow in `.github/workflows/terraform.yml`:

- Runs on pushes and pull requests to the main branch
- Executes `terraform init`, `validate`, `plan`, and—if on the main branch—`apply`
- Uses GitHub Secrets for secure management of Azure credentials

## Code Quality & Best Practices

To ensure maintainability and security:

- Use `terraform fmt` for consistent code formatting
- Run `terraform validate` to catch configuration errors
- Integrate TFLint for static analysis
- Use Terratest for automated integration testing
- Use terraform-docs for automated documentation

## License

[MIT](LICENSE)
