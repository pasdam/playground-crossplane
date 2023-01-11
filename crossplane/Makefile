CROSSPLANE_WORKING_DIR := $(REPO_DIR)/crossplane

## crossplane-install: Install crossplane in the k8s cluster
.PHONY: crossplane-install
crossplane-install: | _crossplane-repo-install
	@helm upgrade --install crossplane --namespace crossplane-system --create-namespace --wait --timeout 300s crossplane-stable/crossplane -f $(CROSSPLANE_WORKING_DIR)/helm-values.yaml
	@kubectl apply -f "$(CROSSPLANE_WORKING_DIR)/aws-provider-config.yaml"

# Internal targets
# ----------------

.PHONY: _crossplane-repo-install
_crossplane-repo-install:
	@helm repo add crossplane-stable https://charts.crossplane.io/stable
	@helm repo update crossplane-stable
