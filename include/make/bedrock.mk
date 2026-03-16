br-install-cloud-tools-dependencies:
	@brew install awscli jq wget bash
.PHONY: br-install-cloud-tools-dependencies

br-install-bedrock-cli: TMP := $(shell mktemp -d)
br-install-bedrock-cli: br-install-cloud-tools-dependencies
	curl -fsSL --output-dir "$(TMP)" --remote-name \
		"$$BR_GITHUB_URL/raw/devops/bedrock-cli/master/install.sh" \
		&& chmod u+x $(TMP)/install.sh && $(TMP)/install.sh
.PHONY: br-install-bedrock-cli