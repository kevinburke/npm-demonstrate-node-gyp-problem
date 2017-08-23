SHELL := /bin/bash -o pipefail

NPM := node_modules/.bin/npm
NPM_OPTS = --color=false --send-metrics=false --progress=false --prefer-offline
GLOBAL_NPM = $(shell command -v npm)
ifeq ($(GLOBAL_NPM),)
	GLOBAL_NPM = rebuild
endif

var/src/v5.3.0.tar.gz:
	mkdir -p var/src
	curl --location --silent https://github.com/npm/npm/archive/v5.3.0.tar.gz > var/src/v5.3.0.tar.gz

$(NPM): | $(GLOBAL_NPM) var/src/v5.3.0.tar.gz logs
	# this might be npm 2
	time $(GLOBAL_NPM) install $(NPM_OPTS) --cache-min 9999999 var/src/v5.3.0.tar.gz
	$(NPM) --version

install: | $(NPM) logs
	$(NPM) install $(NPM_OPTS)

logs:
	mkdir -p logs
