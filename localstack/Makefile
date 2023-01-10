LOCALSTACK_WORKING_DIR := $(REPO_DIR)/localstack

## localstack-install: Install localstack in the k8s cluster
.PHONY: localstack-install
localstack-install: | _localstack-repo-install
	@helm upgrade --install localstack --namespace localstack --create-namespace --wait --timeout 300s localstack-repo/localstack -f $(LOCALSTACK_WORKING_DIR)/helm-values.yaml

# Internal targets
# ----------------

.PHONY: _localstack-repo-install
_localstack-repo-install:
	@helm repo add localstack-repo https://helm.localstack.cloud
	@helm repo update localstack-repo
