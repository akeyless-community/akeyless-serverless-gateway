# Variables
RESOURCE_GROUP = akeless-serverless-gateway
LOCATION = eastus
BICEP_MAIN = main.bicep
BICEP_PARAMS = params.bicepparam

# Default target
.PHONY: all
all: deploy

# Check Azure CLI version
.PHONY: check-versions
check-versions:
	@echo "Checking Azure CLI and Bicep versions..."
	az --version
	az bicep version

# Lint Bicep files
.PHONY: lint
lint:
	@echo "Linting Bicep files..."
	az bicep lint --file $(BICEP_MAIN) --file $(BICEP_PARAMS)

# Create resource group
.PHONY: create-rg
create-rg:
	@echo "Creating resource group..."
	az group create --name $(RESOURCE_GROUP) --location $(LOCATION)

# Deploy Bicep template
.PHONY: deploy
deploy: check-versions lint create-rg
	@echo "Deploying Bicep template..."
	az deployment group create \
		--resource-group $(RESOURCE_GROUP) \
		--template-file $(BICEP_MAIN) \
		-p $(BICEP_PARAMS) \
		--query "properties.outputs.functionAppURL.value"

# Clean up resources
.PHONY: clean
clean:
	@echo "Cleaning up resources..."
	az group delete --name $(RESOURCE_GROUP) --yes --no-wait

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all          - Run full deployment (default)"
	@echo "  check-versions - Check Azure CLI and Bicep versions"
	@echo "  lint         - Lint Bicep files"
	@echo "  create-rg    - Create resource group"
	@echo "  deploy       - Deploy Bicep template"
	@echo "  clean        - Delete resource group"
	@echo "  help         - Show this help message"