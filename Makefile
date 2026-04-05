.PHONY: lint hooks

lint:
	@bash scripts/lint.sh

hooks:
	@echo "Installing pre-push hook..."
	@cp scripts/lint.sh .git/hooks/pre-push
	@chmod +x .git/hooks/pre-push
	@echo "Done. 'git push' will now run lint checks before pushing."
