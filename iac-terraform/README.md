# URL Shortner Application using Terraform

![Alt text](assets/images/url-shortner.png?raw=true "Architecture")

This project contains the Terraform implementation of a URL shortner Application.The application uses several AWS resources - Lambda functions, an API Gateway API, and Amazon DynamoDB tables. The runtime for the Lambda functions is PYTHON 3.10. The project is structured as follows:

- `modules` - Contains the Iac configurations of Lambda functions and API Gateway methods. The significance of modules in terraform is the reusability of the terraform resources and data blocks for differnent AWS components.
- `lambda-function-code` - This folders contains the source code(business logic) of the Lambda functions.
- `assets/ images` - Contains the images and other miscellaneous files.
- The root module conatins the tf files for DynamoDB, IAM Policies, Lambda and REST Apis where all the modules are invoked and used.

## How to start and deploy the application using Terraform

- The initial setup that has to be done is to configure the AWS authentication of the user using which the application is to be deployed to the AWS. There are number of options available. Please refer [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration) and chose the appropriate one. Warning: Hard-coded credentials are not recommended in any Terraform configuration and risks secret leakage should this file ever be committed to a public version control system.

- The provider used here is the AWS provider, and the remote backend has been configured to AWS S3 bucket. AWS S3 bucket has to be created and configured prior to the terraform initiation.

- Run the Terraform init command. The terraform init command initializes a working directory containing configuration files and installs plugins for required providers.

- Terraform Plan

- Terraform apply to deploy the application.

## Resources

For AWS Terraform Documentation please refer [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).
For Terraform HCL Language Documentation please refer [here](https://developer.hashicorp.com/terraform/language).
