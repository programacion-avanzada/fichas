.PHONY: serve deploy lint

serve:
	docsify serve .

deploy:
	git push

lint:
	npx --yes markdownlint-cli2
