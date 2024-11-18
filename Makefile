
deps:
	@echo "Dependencies are managed by uv"

remote/new-vps-setup:
	@echo "Running setup"
	uvx --from "ansible-core" \
		ansible-playbook -i hosts.yml playbooks/01_setup.yml

remote/setup-nginx:
	@echo "Setting up nginx"
	uvx --from "ansible-core" \
		ansible-playbook -i hosts.yml playbooks/02_nginx.yml

remote/copy-some-test-data:
	@echo "Copying some test data"
	uvx --from "ansible-core" \
		ansible-playbook -i hosts.yml playbooks/03_copy_some_test_data.yml
