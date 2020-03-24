docs:
	@printf "\033[0;32m>>> Running pre-commit hook manually\033[0m\n"
	pre-commit run --all-files
