
deps:
	@echo "Dependencies are managed by uv"

remote/01-new-vps-setup:
	@echo "Running setup"
	uvx --from "ansible-core" \
		ansible-playbook -i hosts.yml playbooks/01_setup.yml

remote/02-setup-nginx:
	@echo "Setting up nginx"
	uvx --from "ansible-core" \
		ansible-playbook -i hosts.yml playbooks/02_nginx.yml

remote/03-copy-some-test-data:
	@echo "Copying some test data"
	uvx --from "ansible-core" \
		ansible-playbook -i hosts.yml playbooks/03_test_data.yml
