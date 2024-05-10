# Akeyless Serverless Gateway
This Terraform module creates an Akeyless Serverless Gateway in your AWS account.
![Akeyless Serverless Gateway.png](terraform%2FAkeyless%20Serverless%20Gateway.png)
## Prerequisites
- Terraform installed (>=1.0.0): [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Choose your desired [Terraform Backend](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)
- An AWS account with the required `create` permission and `access key` credentials.

## Installation

### Configure the Terraform Module

#### Clone the Serverless Gateway Repo

Clone the serverless gateway repo (or download it): *https://github.com/akeyless-community/serverless-gateway*

```shell Shell
git clone https://github.com/akeyless-community/serverless-gateway
```
#### Edit the Serverless Gateway Environment Variables

Go to the folder on your local machine where you cloned the repo and edit the *"lambda_env_vars.tf"* file with your desired inputs in the relevant variable fields for Akeyless Serverless Gateway Configuration. These are the required fields for your deployment.

The following are required fields:
| Required env vars|
| :---------------------------------------------------|
| akeyless_url|
| admin_access_id_type|
| admin_access_id|
| admin_access_key (if admin_access_id_type="access_key")|
| akeyless_account_id|

Below is a sample Terraform file:

```shell TF
variable "akeyless_url" {
  description = "Required. This is the url for Akeyless service, available inputs are https://vault.akeyless.io or  https://vault.eu.akeyless.io"
  type        = string
  default     = "https://vault.akeyless.io"
}

variable "admin_access_id_type" {
  description = "Required. Allowed values are 'aws_iam' or 'access_key'. See: https://docs.akeyless.io/docs/access-and-authentication-methods. Default value is 'aws_iam'."
  type        = string
  default     = "aws_iam"
}

variable "admin_access_id" {
  description = "Required. Akeyless Admin Access ID. See: https://docs.akeyless.io/docs/advance-gw-docker-configuration#api-key-authentication"
  type        = string
  default     = ""
}

variable "admin_access_key" {
  description = "Required if "admin_access_id_type"="access_key". Akeyless Admin Access Key. See: https://docs.akeyless.io/docs/advance-gw-docker-configuration#api-key-authentication"
  type        = string
  default     = ""
}

variable "akeyless_account_id" {
  description = "Akeyless Admin Account ID https://docs.akeyless.io/docs/advance-gw-docker-configuration"
  type        = string
  default     = ""
}

variable "customer_fragments" {
  description = <<DESCRIPTION
  Akeyless Customer key fragments (Zero Knowledge).
  For more information https://docs.akeyless.io/docs/implement-zero-knowledge
  The input should be in json format for example :
  {
    "customer_fragments": [
        {
            "id": "cf-xyzxyzxyzxyzxyzxyz",
            "value": "SomE/CUstOmer/FrAGMenTvALue==",
            "description": "MyFirstCF"
        }
    ]
}
  DESCRIPTION
  type        = map(any)
  sensitive   = true
  default     = {}
}

variable "initial_display_name" {
  description = "Initial Display Name for more information https://docs.akeyless.io/docs/advance-gw-docker-configuration#cluster-name--url"
  type        = string
  default     = "Lambda"
}

variable "cluster_name" {
  description = "Cluster Name for more information https://docs.akeyless.io/docs/advance-gw-docker-configuration#cluster-name--url"
  type        = string
  default     = "Lambda"
}
```

> 👍 Note
>
> We suggest also opening and editing the *"variables.tf"* file which has some variables that make sense, but aren't required, to update. For example, updating the _lambda_func_name_ variable helps you to find your gateway in AWS more easily and also choose the desired AWS Region by updating the "region" variable

### Install the Terraform module

To install the module, run the following commands:

```shell Shell
terraform init
```
```shell Shell
terraform plan
```
```shell Shell
terraform apply
```
When the installation is complete, you should see something similar to the following. Note that any text between < > represents a variable you can edit.

```shell Shell
Outputs:

akeyless_serverless_gateway_url = "https://uh4i3r4.execute-api.<region>.amazonaws.com/default/console"
aws_api_gateway_rest_api = "arn:aws:apigateway:<region>::/restapis/uh4i3r4"
aws_lambda_function = "arn:aws:lambda:<region>:<aws-acct-id>:function:<your-serverless-gateway>"
repository_url = "<aws-acct-id>.dkr.ecr.<region>.amazonaws.com/<your>-serverless-gateway-repo-for-lambda"
```

## Initial Gateway Configuration

To configure your Akeyless Gateway:

1. On your browser, navigate to the URL in the first output: _akeyless_serverless_gateway_url_.

2. Enter your credentials to log in.

## Lambda Docker Image Configuration

- **Current Image Tag**: The Docker image is currently using the tag of the latest version available. This image is automatically sourced from the AWS ECR Public Gallery.

- **Selecting a Different Version**: To use a different version, or to Update the version please visit [this page](https://gallery.ecr.aws/akeyless/serverless-gateway) to view available versions. Once you've chosen the desired version, update the `image_tag` variable accordingly.

- **Deployment Process**: After updating the `image_tag` and applying the Terraform changes, the new image will be copied to your private ECR in the specified region. This process is managed by a dedicated Terraform Module, which also updates the Lambda Docker image.
