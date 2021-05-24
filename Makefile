ANSIBLE_ENVIRONMENT = PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ANSIBLE_HOST_KEY_CHECKING=false \
	ANSIBLE_SSH_ARGS="$(ANSIBLE_SSH_ARGS)"

ANSIBLE_SSH_ARGS = -o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o ControlMaster=auto \
	-o ControlPersist=60s

override ANSIBLE_PLAYBOOK_FLAGS += --connection=ssh --timeout=30 --limit="$(ANSIBLE_LIMIT)" \
	--extra-vars "use_google_dns=false" \
  --vault-id "$(VAULT_ID)@$(VAULT_PASS_FILE)"

ANSIBLE_INVENTORY_FILE = .vagrant/provisioners/ansible/inventory
ANSIBLE_LIMIT := all

VAULT_ID::=do_mxpatlas
VAULT_PASS_FILE::=~/.secret/vault.do_mxpatlas

all:
	@echo Usage: make ansible

.PHONY: ansible
ansible:
	$(ANSIBLE_ENVIRONMENT) ansible-playbook $(ANSIBLE_PLAYBOOK_FLAGS) \
		--inventory-file="$(ANSIBLE_INVENTORY_FILE)" -v ansible/site.yml

encrypt:
	echo -n 'Hexlet Awesome Server' \
		| ansible-vault encrypt_string --vault-id  "$(VAULT_ID)@$(VAULT_PASS_FILE)" --stdin-name 'server_message'

galaxy:
	ansible-galaxy install -v -r requirements.yml
	ansible-galaxy collection install -v -r requirements.yml
