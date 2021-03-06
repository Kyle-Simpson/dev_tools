# Tutorial on Make's assignment operators:
# = lazy set, := immediate set, ?= lazy set If absent, += append, != shell assignment

this_makefile   := $(lastword $(MAKEFILE_LIST))
.DEFAULT_GOAL   := help                          # useful to set default goal

OUTPUT_DIR      := output
CONDA_ENV_DIR   := $(shell dirname $(CONDA_ENV_PATH) 2> /dev/null )


build_env:
	@echo "Building Conda Env. at path: '${CONDA_ENV_PATH}' as '$(CONDA_ENV_MOUNT_TYPE)' mount type with name: ${CONDA_ENV_NAME}"
	conda remove -p $(CONDA_ENV_PATH) --all --yes
	rm -rf $(CONDA_ENV_PATH) # safety net in case above remove did not remove all packages
	@# env. is created using path, without a name though
	conda create -p $(CONDA_ENV_PATH) python=3.9 "pip>=21.1" --yes
	conda env list


install:
	@echo "Installing packages into ${CONDA_ENV_PATH}
	# use preferred installer (poetry, pip, conda, etc.)


format: # Run the code formatter and import sorter
	black $(LOCATIONS)
	isort -rc $(LOCATIONS)
	@echo "Ignore, Created by Makefile, `date`" > $@


safety_check: # Run safety check
	safety check --full-report $(SAFETY_IGNORE)


lint: $(PY_FILES:%=.lint/%)


.lint/%.py: %.py
	flake8 --show-source --statistics --benchmark $<
	mkdir -p $(shell dirname $@)
	touch $@


typecheck: # Run type checker
	pytype --jobs 4 --keep-going $(LOCATIONS)
	@echo "Ignore, Created by Makefile, `date`" > $@


automated_tests: # Run all the tests that can be run "in automation" (i.e. on Jenkins).
	COVERAGE_FILE=.coverage.ui PYTHONPATH=$(PYTHONPATH):src/. pytest --cov --cov-config=pyproject.toml --xdoctest --junit-xml=$(OUTPUT_DIR)/test-report.xml -m "not e2e"
	COVERAGE_FILE=.coverage.ui coverage html --title="$(PACKAGE_NAME) - Test Coverage" -d $(OUTPUT_DIR)/coverage-test


clean:             # Clean up files/services produced by make system
	@echo "Cleaning..."
	@rm -rf $(OUTPUT_DIR)
	@rm -rf format lint typecheck .pytest_cache .pytype .coverage.ui .lint
	@rm -rf __pycache__ */__pycache__ */*/__pycache__ */*/*/__pycache__

