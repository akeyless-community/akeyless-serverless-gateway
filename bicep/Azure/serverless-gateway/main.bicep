@description('Application suffix that will be applied to all resources')
param appSuffix string = uniqueString(resourceGroup().id)

@description('The location to deploy all my resources')
param location string = resourceGroup().location

@description('The name of the log analytics workspace')
param logAnalyticsWorkspaceName string = 'log-${appSuffix}'

@description('The name of the Application Insights workspace')
param appInsightsName string = 'appinsights-${appSuffix}'

@description('Name of the managed environment')
param managedEnvironmentName string

@description('Name of the storage account')
param storageAccountName string = 'storageaccount${appSuffix}'

@description('Name of the storage account SKU')
param storageAccountSkuName string = 'Standard_LRS'

param functionAppName string

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
    name: logAnalyticsWorkspaceName
    location: location
    properties: {
        sku: {
            name: 'PerGB2018'
        }
        retentionInDays: 30
    }
}

resource appInsights 'microsoft.insights/components@2020-02-02' = {
    name: appInsightsName
    location: location
    kind: 'web'
    properties: {
        Application_Type: 'web'
        WorkspaceResourceId: logAnalytics.id
        IngestionMode: 'LogAnalytics'
        publicNetworkAccessForIngestion: 'Enabled'
        publicNetworkAccessForQuery: 'Enabled'
    }
}

resource managedEnvironment 'Microsoft.App/managedEnvironments@2024-03-01' = {
    name: managedEnvironmentName
    location: location
    properties: {
        appLogsConfiguration: {
            destination: 'log-analytics'
            logAnalyticsConfiguration: {
                customerId: logAnalytics.properties.customerId
                sharedKey: logAnalytics.listKeys().primarySharedKey
            }
        }
    }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-04-01' = {
    name: storageAccountName
    location: location 
    sku: {
        name: storageAccountSkuName
    }
    kind: 'StorageV2'
    properties: {
        supportsHttpsTrafficOnly: true
    }
}

param initial_display_name string
param akeyless_url string
param cluster_name string
param admin_access_id_type string
param admin_access_id string
param admin_access_key string
param allowed_access_permissions string
param customer_fragments string
param docker_img string
param docker_tag string
param admin_account_id string

resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
    name: functionAppName
    location: location
    tags: {}
    kind: 'functionapp,linux,container,azurecontainerapps'
    identity: {
        type:  admin_access_id_type == 'azure' ? 'SystemAssigned' : 'None'
    }
    properties: {
        siteConfig: {
            linuxFxVersion: 'DOCKER|${docker_img}:${docker_tag}'
            functionAppScaleLimit: 10
            minimumElasticInstanceCount: 1
            cors: {
                allowedOrigins: ['https://console.akeyless.io']
                }
        }
        managedEnvironmentId: managedEnvironment.id
        storageAccountRequired: false
    }
}

var storageAccountConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=${environment().suffixes.storage}'

var envVars = [
    {
        name: 'INITIAL_DISPLAY_NAME'
        value: initial_display_name
    }
    {
        name: 'AKEYLESS_URL'
        value: akeyless_url
    }
    {
        name: 'CLUSTER_NAME'
        value: cluster_name
    }
    {
        name: 'ADMIN_ACCESS_ID_TYPE'
        value: admin_access_id_type
    }
    {
        name: 'ADMIN_ACCESS_ID'
        value: base64(admin_access_id)
    }
    {
        name: 'ALLOWED_ACCESS_PERMISSIONS'
        value: allowed_access_permissions
    }
    {
        name: 'CLUSTER_URL'
        value: 'HTTPS://${functionApp.properties.defaultHostName}/api/gw/console'
    }
    {
        name: 'CUSTOMER_FRAGMENTS'
        value: customer_fragments
    }
    {
        name: 'ADMIN_ACCOUNT_ID'
        value: admin_account_id
    }
    {
        name: 'AzureWebJobsStorage'
        value: storageAccountConnectionString
    }
]

var extraVars = [
    {
        name: 'ADMIN_ACCESS_KEY'
        value: admin_access_key
    }
]

var appInsightsVars = [
    {
        name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
        value: appInsights.properties.ConnectionString
    }
    {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: appInsights.properties.InstrumentationKey
    }
    {
        name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
        value: '~3'
    }
]

var combined = union(
    admin_access_id_type == 'azure' ? envVars : union(envVars, extraVars),
    appInsightsVars
)

resource updateAppSettings 'Microsoft.Web/sites/config@2022-03-01' = {
    parent: functionApp
    name: 'web'
    properties: {
        linuxFxVersion: 'DOCKER|${docker_img}:${docker_tag}'
        functionAppScaleLimit: 10
        minimumElasticInstanceCount: 1
        appSettings: combined
        cors: {
            allowedOrigins: ['https://console.akeyless.io']
            }
    }
}

output FunctionAppURL string = 'https://${functionApp.properties.defaultHostName}/api/gw/console'
