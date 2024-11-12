using 'main.bicep'

@description('Initial Display Name')
param initial_display_name = 'function_app'

@description('''This is the url for Akeyless service,
available inputs are https://vault.akeyless.io or  https://vault.eu.akeyless.io''')
param akeyless_url = 'https://vault.akeyless.io'

@description('Cluster Name')
param cluster_name = 'function_app'

@description('Allowed values are azure or access_key https://docs.akeyless.io/docs/access-and-authentication-method')
    param admin_access_id_type = 'azure'

@description('Admin Account ID')
param admin_account_id = '<admin_account_id>'

@description('Akeyless Admin Access ID')
param admin_access_id = '<admin_access_id>'

@description('Akeyless Admin Access Key - not relevant when admin_access_id_type = azure')
param admin_access_key = '<admin_access_key>'

@description('''Akeyless Allowed Access Permissions
                  The input should be in this json format. See the below example:
                  '[{"name": "", "access_id": "", "permissions": ["admin"]}]'
                  ''')
param allowed_access_permissions = '[{\"name\": \"\", \"access_id\": \"\", \"permissions\": [\"admin\"]}]'

@description('''Akeyless Customer key fragments (Zero Knowledge).
                For more information https://docs.akeyless.io/docs/implement-zero-knowledge
                The input should be in json format. See the below example.
                Use the exact format here inside the {braces} and add it to the `default = ` empty value below.
                {
                  "customer_fragments": [
                      {
                          "id": "<Customer Fragment ID>",
                          "value": "<Value>",
                          "description": "My Serverless Fragment",
                          "name": "ServerLessFragment"
                      }
                  ]
                }''')
param customer_fragments = '{}'

@description('The name of the function app')
param functionAppName = 'akeyless-serverless-gateway'

@description('Name of the managed environment')
param managedEnvironmentName = 'serverless-gateway'

@description('docker image')
param docker_img = 'akeyless.azurecr.io/akeyless/serverless-gateway'

@description('docker tag')
param docker_tag = '0.0.24'
