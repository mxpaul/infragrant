# Infragrant - infrastructure in vagrant

## What is this

This repository is an example of closer-to-real-world infrastructure management with ansible.
This is not a production ready sulution.
This is not an ansible galaxy collection. 

## How to use

1. Set up `vagrant` on your machine (notebook, PC, etc). https://www.vagrantup.com/downloads
2. Clone this repository.
```bash
    git clone https://github.com/mxpaul/infragrant.git 
```
3. Run `vagrant up` at repository root
```bash
    cd infragrant
    vagrant up
```


## Examples

- Only set up named on ns1 machine:
```
make ANSIBLE_PLAYBOOK_FLAGS="--tags named" ANSIBLE_LIMIT=ns1 ansible
```
