help:
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1m%-10s\033[0m %s\n", $$1, $$2}'


clean:
	@rm -rf .terraform

dev-apply: clean ## create dev environment
	@terraform init
	@terraform apply -auto-approve -var-file=end/provider.tf

