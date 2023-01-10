REPO_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.DEFAULT_GOAL := help

include $(REPO_DIR)/crossplane/Makefile
include $(REPO_DIR)/k3d/Makefile

## help: Display this help screen
.PHONY: help
help:
	@sed -n 's/^## //p' $(MAKEFILE_LIST) | awk '\
		BEGIN { FS = "(:|^) +"}; \
		/^[a-zA-Z0-9\-]+: .*/ { printf "\033[36m%-30s\033[0m%s\n", $$1, $$2; next }; \
		/^ +.*/ { printf "\033[36m%-30s\033[0m", ""; printf $$2; for (i=3; i<=NF; i++) { printf ":%s", $$i }; printf "\n" } \
		'
