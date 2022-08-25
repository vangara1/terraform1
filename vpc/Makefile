help:
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1m%-10s\033[0m %s\n", $$1, $$2}'


clean:
	@rm -rf .terraform

dev-apply: clean ## create dev environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform apply -auto-approve -var-file=env/provider.tf

prod-apply: clean ## create prod environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform apply -auto-approve -var-file=env/provider.tf

dev-destroy: clean ## create dev environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform destroy -auto-approve -var-file=env/provider.tf

prod-destroy: clean ## create prod environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform destroy -auto-approve -var-file=env/provider.tf

