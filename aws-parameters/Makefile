git:
	git pull
dev: git
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars

prod: git
	terraform init -backend-config=env-prod/state.tfvars
	terraform apply -auto-approve -var-file=env-prod/main.tfvars



#git:
#	git pull
#
#dev-apply: git
#	cd aws-parameters
#	terraform init -backend-config=env-dev/state.tfvars
#	terraform apply -auto-approve -var-file=env-dev/main.tfvars
#	cd ..
#	terraform init -backend-config=env-dev/state.tfvars
#	terraform apply -auto-approve -var-file=env-dev/main.tfvars
#
#dev-destroy: git
#	terraform init -backend-config=env-dev/state.tfvars
#	terraform destroy -auto-approve -var-file=env-dev/main.tfvars
#
#prod-apply: git
#	cd aws-parameters
#	terraform init -backend-config=env-prod/state.tfvars
#	terraform apply -auto-approve -var-file=env-prod/main.tfvars
#	cd ..
#	terraform init -backend-config=env-prod/state.tfvars
#	terraform apply -auto-approve -var-file=env-prod/main.tfvars
#
#prod-destroy: git
#	terraform init -backend-config=env-prod/state.tfvars
#	terraform destroy -auto-approve -var-file=env-prod/main.tfvars
