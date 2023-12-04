LOCAL_BIN := $(HOME)/.local/bin

br-install-cloud-tools-dependencies:
	@brew install awscli bash jq saml2aws wget
.PHONY: br-install-cloud-tools-dependencies

br-install-cloud-tools:
	@curl -fsSL "$$BR_GITHUB_URL/raw/sysadmin/setup-dev-env/master/cloud-tools/install.sh" \
		| bash
.PHONY: br-install-cloud-tools

br-install-cloud-aliases:
	@curl -fsSL --create-dirs --output-dir "$(LOCAL_BIN)" --remote-name \
		"$$BR_GITHUB_URL/raw/sysadmin/setup-dev-env/master/cloud-tools/cloud_functions.sh"
.PHONY: br-install-cloud-aliases

br-setup-awscli: TMP := $(shell mktemp -d)
br-setup-awscli:
	@wget -O "$(TMP)/setup-awscli.sh" \
		"$$BR_GITHUB_URL/raw/sysadmin/setup-dev-env/master/cloud-tools/setup-awscli.sh"
	@bash $(TMP)/setup-awscli.sh
	@rm -rf $(TMP)
.PHONY: br-setup-awscli

br-check-nr-credentials:
	@curl -s -X GET 'https://api.eu.newrelic.com/v2/applications.json' -H "Api-Key:$$NEW_RELIC_API_KEY" -i | \
		grep -q "No API key" \
		&& echo "$(FAILURE)You have to define NEW_RELIC_API_KEY." \
		|| echo "$(SUCCESS)New Relic credentials are correctly set."
.PHONY: br-check-nr-credentials

br-setup-cloud: \
	br-install-cloud-tools-dependencies \
	br-install-cloud-tools \
	br-setup-awscli \
	br-install-cloud-aliases \
	br-check-nr-credentials
	@saml2aws login --force --cache-saml --skip-prompt
.PHONY: br-setup-cloud

br-cleanup-cloud:
	@rm -rf $(HOME)/.saml2aws $(HOME)/.aws
	@rm -f $(LOCAL_BIN)/cloud_functions.sh
.PHONY: br-cleanup-cloud