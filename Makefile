.PHONY: serve deploy lint

serve:
	docsify serve . --port 3001

deploy:
	git push

lint:
	npx --yes markdownlint-cli2
