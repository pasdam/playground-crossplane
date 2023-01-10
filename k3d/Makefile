K3D_CONFIG := $(REPO_DIR)/k3d/config.yaml

K8S_CURRENT_CONTEXT := $(shell kubectl config current-context)
CLUSTER_NAME ?= $(shell grep '^  name: ' $(K3D_CONFIG) | awk '{print $$2}')
K3D_CLUSTER := $(shell k3d cluster list --no-headers "$(CLUSTER_NAME)" 2> /dev/null | awk '{print $$1}')

## cluster-create: Create the local k8s cluster using K3d
.PHONY: cluster-create
cluster-create: | cluster-start

## cluster-delete: Delete the local K3d cluster
.PHONY: cluster-delete
cluster-delete:
	@k3d cluster delete --config "$(K3D_CONFIG)"

## cluster-start: Create the local k8s cluster using K3d or create a previously stopped one
.PHONY: cluster-start
cluster-start: | _cluster-start _switch-context

## cluster-stop: stop a previously stopped cluster
.PHONY: cluster-stop
cluster-stop:
	@k3d cluster stop "$(CLUSTER_NAME)"

# Internal targets
# ----------------

.PHONY: _cluster-start
_cluster-start:
ifeq ($(K3D_CLUSTER),)
	@echo "Creating cluster"
	@k3d cluster create --config "$(K3D_CONFIG)"
else
	@echo "Starting cluster"
	@k3d cluster start "$(CLUSTER_NAME)"
endif

.PHONY: _switch-context
_switch-context:
ifneq ($(K8S_CURRENT_CONTEXT),k3d-$(CLUSTER_NAME))
	@kubectl config use-context "k3d-$(CLUSTER_NAME)"
else
	@echo "Using $(K8S_CURRENT_CONTEXT) context"
endif
