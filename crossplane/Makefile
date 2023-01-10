CROSSPLANE_WORKING_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

## crossplane-install: Install crossplane in the k8s cluster
.PHONY: crossplane-install
crossplane-install: | _crossplane-repo-install
	@helm upgrade --install crossplane --namespace crossplane-system --create-namespace --wait --timeout 300s crossplane-stable/crossplane

# Internal targets
# ----------------

.PHONY: _crossplane-repo-install
_crossplane-repo-install:
	@helm repo add crossplane-stable https://charts.crossplane.io/stable
	@helm repo update crossplane-stable
