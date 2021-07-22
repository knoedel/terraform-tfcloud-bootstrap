.PHONY: ensure_pre_commit
ensure_pre_commit: .git/hooks/pre-commit .git/hooks/commit-msg
.git/hooks/pre-commit:
	pre-commit install
	pre-commit install-hooks

.git/hooks/commit-msg:
	pre-commit install --hook-type commit-msg

.PHONY: pre_commit_tests
pre_commit_tests: ensure_pre_commit ## Run pre-commit tests
	pre-commit run --all-files

.PHONY: test
test: pre_commit_tests
	  scripts/make-test

.PHONY: clean
clean:
	rm -f .*.stamp
