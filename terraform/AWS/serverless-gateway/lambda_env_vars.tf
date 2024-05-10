
variable "initial_display_name" {
  description = "Initial Display Name"
  type        = string
  default     = "Lambda"
}

variable "akeyless_url" {
  description = "This is the url for Akeyless service, available inputs are https://vault.akeyless.io or  https://vault.eu.akeyless.io"
  type        = string
  default     = "https://vault.akeyless.io"
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = "Lambda"
}

variable "admin_access_id_type" {
  description = "Allowed values are aws_iam or access_key https://docs.akeyless.io/docs/access-and-authentication-methods"
  type        = string
  default     = "aws_iam"
}

variable "admin_access_id" {
  description = "Akeyless Admin Access ID"
  type        = string
  default     = ""
}

variable "allowed_access_permissions" {
  description = <<DESCRIPTION
  Akeyless Allowed Access Permissions
  The input should be in this json format. See the below example:
  "[{\"name\": \"\", \"access_id\": \"\", \"permissions\": [\"admin\"]}]"
  DESCRIPTION
  type        = string
  default     = ""
}

variable "admin_access_key" {
  description = "Akeyless Admin Access Key - not relevant when admin_access_id_type = aws_iam"
  type        = string
  default     = ""
}

variable "akeyless_account_id" {
  description = "Akeyless Admin Account ID"
  type        = string
  default     = ""
}

variable "customer_fragments" {
  description = <<DESCRIPTION
  Akeyless Customer key fragments (Zero Knowledge).
  For more information https://docs.akeyless.io/docs/implement-zero-knowledge
  The input should be in json format. See the below example.
  Use the exact format here inside the {braces} and add it to the `default = ` empty value below.
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
