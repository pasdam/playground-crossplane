LOCALSTACK_WORKING_DIR := $(REPO_DIR)/localstack

## localstack-init: Initialize localstack requirements
.PHONY: localstack-init
localstack-init: | _localstack-repo-install
	@docker pull localstack/localstack:1.3.1
	@k3d image import --cluster $(CLUSTER_NAME) localstack/localstack:1.3.1

## localstack-install: Install localstack in the k8s cluster
.PHONY: localstack-install
localstack-install: | _localstack-repo-install
	@helm upgrade --install localstack --namespace localstack --create-namespace --wait --timeout 300s localstack-repo/localstack -f $(LOCALSTACK_WORKING_DIR)/helm-values.yaml

## localstack-generate-template: Generate the localstack helm templare
.PHONY: localstack-generate-template
localstack-generate-template:
	@helm template localstack --namespace localstack localstack-repo/localstack -f $(LOCALSTACK_WORKING_DIR)/helm-values.yaml

## localstack-get-vpcs: Get VPCs in localstack
.PHONY: localstack-get-vpcs
localstack-get-vpcs:
	@echo "VPCs:"
	@aws ec2 describe-vpcs --region=me-south-1 --endpoint-url=http://localhost:30066 | jq '[ .Vpcs[] | { id: .VpcId, cidr: .CidrBlock, name: .Tags[] | select(.Key == "crossplane-name") | .Value } ]'
	@echo "Subnets:"
	@aws ec2 describe-subnets --region=me-south-1 --endpoint-url=http://localhost:30066 | jq '[ .Subnets[] | { id: .SubnetId, cidr: .CidrBlock, name: (.Tags // []) | .[] | select(.Key == "crossplane-name") | .Value } ]'

# Internal targets
# ----------------

.PHONY: _localstack-repo-install
_localstack-repo-install:
	@helm repo add localstack-repo https://helm.localstack.cloud
	@helm repo update localstack-repo
