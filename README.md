# WT Infrastructure

To manage WT infrastructure on AWS by Terraform

# Terraform
Terraform `v1.3.8` is required, otherwise commands are not going to be executed due to the version mismatch.

## Install Terraform
### Linux
### macOS 
tfswitch can be installed with homebrew and in case you have installed `terraform` with brew before, remove it and let `tfswitch` manage the versions.
```
# Update formulaes first
brew update

# Install tfswitch
brew install warrensbox/tap/tfswitch

# Install and enable version
tfswitch 1.3.8

# Double check enabled version
terraform --version
```

## Deployment

### Documentation
* https://www.terraform.io/cloud-docs/run/states

### Stage 1-3
Keep in mind that stages have to be planned and applied in sequence, as Terraform can’t resolve all resource dependencies in one go. 

* **stage_number:** stage1 | stage2 | stage3
* **environment_name:** staging | production

```
# Initialize Terraform with backend config
terraform -chdir=./main/<stage_number> init -backend-config="../../backend-configs/staging/<stage_number>.tf"

# Create/Select workspace
terraform workspace new <environment_name>
terraform workspace select <environment_name>

# Plan deployment
terraform -chdir=./main/<stage_number> plan

# Execute and apply plan
terraform -chdir=./main/<stage_number> apply
```
