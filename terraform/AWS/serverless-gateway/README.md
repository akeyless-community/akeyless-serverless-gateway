## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.22.0 |
| <a name="requirement_skopeo2"></a> [skopeo2](#requirement\_skopeo2) | 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |
| <a name="provider_skopeo2"></a> [skopeo2](#provider\_skopeo2) | 1.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.api_gw_deployment](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.proxy](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration.proxy_root](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration_response.proxy_root_integration_response](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_integration_response) | resource |
| [aws_api_gateway_method.proxy](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method.proxy_root](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method_response.proxy_root_response](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_method_response) | resource |
| [aws_api_gateway_resource.proxy](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.rest_api](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/api_gateway_rest_api) | resource |
| [aws_cloudwatch_event_rule.cloudwatch_event_rule](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.cloudwatch_event_target](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecr_repository.ecr_repo](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/ecr_repository) | resource |
| [aws_iam_policy.function_logging_policy](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.function_logging_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_func](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch_execution](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.lambda_permission_root](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/lambda_permission) | resource |
| [skopeo2_copy.image_copy](https://registry.terraform.io/providers/bsquare-corp/skopeo2/1.1.0/docs/resources/copy) | resource |
| [aws_api_gateway_rest_api.rest_api](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/api_gateway_rest_api) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/caller_identity) | data source |
| [aws_ecr_authorization_token.ecr_token](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/ecr_authorization_token) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_access_id"></a> [admin\_access\_id](#input\_admin\_access\_id) | Akeyless Admin Access ID | `string` | `""` | no |
| <a name="input_admin_access_id_type"></a> [admin\_access\_id\_type](#input\_admin\_access\_id\_type) | Allowed values are aws\_iam or access\_key https://docs.akeyless.io/docs/access-and-authentication-methods | `string` | `"aws_iam"` | no |
| <a name="input_admin_access_key"></a> [admin\_access\_key](#input\_admin\_access\_key) | Akeyless Admin Access Key - not relevant when admin\_access\_id\_type = aws\_iam | `string` | `""` | no |
| <a name="input_akeyless_account_id"></a> [akeyless\_account\_id](#input\_akeyless\_account\_id) | Akeyless Admin Account ID | `string` | `""` | no |
| <a name="input_akeyless_url"></a> [akeyless\_url](#input\_akeyless\_url) | This is the url for Akeyless service, available inputs are https://vault.akeyless.io or  https://vault.eu.akeyless.io | `string` | `"https://vault.akeyless.io"` | no |
| <a name="input_allowed_access_permissions"></a> [allowed\_access\_permissions](#input\_allowed\_access\_permissions) | Akeyless allowed\_access\_permissions | `string` | `"[{\"name\": \"\", \"access_id\": \"\", \"permissions\": [\"admin\"]}]"` | no |
| <a name="input_api_gw_deploy_stage_name"></a> [api\_gw\_deploy\_stage\_name](#input\_api\_gw\_deploy\_stage\_name) | The Stage name for the Akeyless Serverless Gateway API Gateway Deployment | `string` | `"default"` | no |
| <a name="input_api_gw_desc"></a> [api\_gw\_desc](#input\_api\_gw\_desc) | The description of the Akeyless Serverless Gateway API-Gateway | `string` | `"Akeyless Serverless Gateway API-Gateway"` | no |
| <a name="input_api_gw_name"></a> [api\_gw\_name](#input\_api\_gw\_name) | The name of the Akeyless Serverless Gateway API-Gateway | `string` | `"akeyless-serverless-gateway-api-gateway"` | no |
| <a name="input_api_gw_tags"></a> [api\_gw\_tags](#input\_api\_gw\_tags) | tags for API GW | `map(string)` | `{}` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | AWS profile | `string` | `"default"` | no |
| <a name="input_cloudwatch_event_rule_description"></a> [cloudwatch\_event\_rule\_description](#input\_cloudwatch\_event\_rule\_description) | The description of the Cloudwatch Event Rule | `string` | `"Triggers the Akeyless Serverless Gateway Lambda Function at regular intervals"` | no |
| <a name="input_cloudwatch_event_rule_name"></a> [cloudwatch\_event\_rule\_name](#input\_cloudwatch\_event\_rule\_name) | The name of the Cloudwatch Event Rule | `string` | `"akeyless-serverless-gateway-keepalive"` | no |
| <a name="input_cloudwatch_event_rule_schedule"></a> [cloudwatch\_event\_rule\_schedule](#input\_cloudwatch\_event\_rule\_schedule) | The Schedule Expression for the Cloudwatch Event Role for the Akeyless Serverless Gateway Lambda Function | `string` | `"rate(2 minutes)"` | no |
| <a name="input_cloudwatch_log_group_lambda_name"></a> [cloudwatch\_log\_group\_lambda\_name](#input\_cloudwatch\_log\_group\_lambda\_name) | This is the name of the Cloudwatch log group for Lambda | `string` | `"akeyless-serverless-gateway-lambda-log-group"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster Name | `string` | `"Lambda"` | no |
| <a name="input_create_log_group_for_lambda"></a> [create\_log\_group\_for\_lambda](#input\_create\_log\_group\_for\_lambda) | Set to true to create the CloudWatch log group | `bool` | `true` | no |
| <a name="input_customer_fragments"></a> [customer\_fragments](#input\_customer\_fragments) | Akeyless Customer key fragments (Zero Knowledge).<br>  For more information https://docs.akeyless.io/docs/implement-zero-knowledge<br>  The input should be in json format. See the below example.<br>  Use the exact format here inside the {braces} and add it to the `default = ` empty value below.<br>  {<br>    "customer\_fragments": [<br>        {<br>            "id": "cf-xyzxyzxyzxyzxyzxyz",<br>            "value": "SomE/CUstOmer/FrAGMenTvALue==",<br>            "description": "MyFirstCF"<br>        }<br>    ]<br>  } | `map(any)` | `{}` | no |
| <a name="input_ecr_force_delete"></a> [ecr\_force\_delete](#input\_ecr\_force\_delete) | will delete the repository even if it contains images | `bool` | `false` | no |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | This is the name of the Private ECR repo to store the container image | `string` | `"akeyless-serverless-gateway-repo-for-lambda"` | no |
| <a name="input_ecr_tags"></a> [ecr\_tags](#input\_ecr\_tags) | tags for ECR | `map(string)` | `{}` | no |
| <a name="input_func_logging_policy_name"></a> [func\_logging\_policy\_name](#input\_func\_logging\_policy\_name) | name of the function logging policy | `string` | `"function-logging-policy-test"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Image tag of the image from AWS Public ECR Image Gallery we are pulling from | `string` | `"x.y.z"` | no |
| <a name="input_initial_display_name"></a> [initial\_display\_name](#input\_initial\_display\_name) | Initial Display Name | `string` | `"Lambda"` | no |
| <a name="input_lambda_func_name"></a> [lambda\_func\_name](#input\_lambda\_func\_name) | Then name of the lambda function | `string` | `"akeyless-serverless-gateway"` | no |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | AWS Lambda Memory Size | `string` | `"512"` | no |
| <a name="input_lambda_role_name"></a> [lambda\_role\_name](#input\_lambda\_role\_name) | The name of the IAM role to be assumed by AWS lambda function | `string` | `"iam-role-for-serverless-akeyless-gateway-lambda-test"` | no |
| <a name="input_lambda_tags"></a> [lambda\_tags](#input\_lambda\_tags) | tags for Lambda | `map(string)` | `{}` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | Amount of time your Lambda Function has to run in seconds, has to be set to the highest value 900 seconds | `string` | `"900"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-1"` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | For network connectivity to AWS resources in a VPC, specify a list of security groups in the VPC | `list(string)` | `[]` | no |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_akeyless_serverless_gateway_url"></a> [akeyless\_serverless\_gateway\_url](#output\_akeyless\_serverless\_gateway\_url) | n/a |
| <a name="output_aws_api_gateway_rest_api"></a> [aws\_api\_gateway\_rest\_api](#output\_aws\_api\_gateway\_rest\_api) | The arn of the Created API Gateway |
| <a name="output_aws_lambda_function"></a> [aws\_lambda\_function](#output\_aws\_lambda\_function) | The arn of the created Lambda function |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The ECR image URI |
