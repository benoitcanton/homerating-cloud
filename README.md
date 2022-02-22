# homerating-cloud

## Repository content
This repository contains all the required [Terraform](https://www.terraform.io) scripts to deploy the Google Cloud resources required for the projects. 

## Requirements
Before being able to apply the Terraform scripts you will need:
- The Google cloud CLI installed - see [here](https://cloud.google.com/sdk/docs/install-sdk) for how to install
- Terratorm - see [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)


## How to use
### Projects variables
All the Terraform/Google Cloud variables are stored in the `locals.tf` file.
- `project` is the Google project ID
- `region` is the target Google region for the resources deployed
- `zone` is the zone within the Google region for the resources deployed

### Google Cloud service account
You should create a `credentials.json` file in the root directory with the required credentials variables in it.
See https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started for more details on how to obtain the file from the Google Cloud portal.

### Apply Terraform scripts
To apply the Terraform scripts you run the following commands:

`terraform init` To init the Terraform project

`terraform plan` To validate/visualize the changes that will be applied

`terraform apply` To apply the Terraform scripts and create the GCP resources