.PHONY: help serve open deploy lint

help: ## Muestra esta ayuda
	@grep -E '^[a-z]+:.*## ' $(MAKEFILE_LIST) | awk -F ':.*## ' '{printf "  %-8s %s\n", $$1, $$2}'

serve: ## Sirve el sitio con docsify en el puerto 3001
	docsify serve . --port 3001

open: ## Abre el sitio en una ventana nueva del browser
	vivaldi --new-window http://localhost:3001 >/dev/null 2>&1 &

deploy: ## Pushea a remoto
	git push

lint: ## Corre markdownlint sobre los .md
	npx --yes markdownlint-cli2
