servers=[
	{ :hostname => "ns1",
		:ip => "172.16.8.8",
		:box => "centos/8",
		:ram => 256,
	},
	{ :hostname => "ns2",
		:ip => "172.16.4.4",
		:box => "centos/8",
		:ram => 256,
	},
	{ :hostname => "front1",
		:ip => "172.16.16.10",
		:box => "centos/8",
		:ram => 256,
	},
]

Vagrant.configure("2") do |config|
	############################################################
	### Ability to run locally slightly different steps
	############################################################
	env_name = ENV["ENV_VAGRANT"]
	ansible_group_vars = {}
	if env_name.respond_to?(:to_str) && env_name.eql?("mxp")
		ansible_group_vars['use_google_dns'] = true
	end
	############################################################

	servers.each do |machine|
		config.vm.define machine[:hostname] do |node|
			node.vm.box = machine[:box]
			node.vm.hostname = machine[:hostname]
			node.vm.network "private_network", ip: machine[:ip]
			node.vm.provider "virtualbox" do |vb|
				vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
				vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
				vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
			end


		end
	end

	config.vm.provision "ansible" do |ansible|
		ansible.verbose = "v"
		ansible.playbook = "ansible/site.yml"
		ansible.config_file = "ansible.cfg"
		#ansible.limit = "all"
		ansible.groups = {
			"nameservers"      => [ "ns1", "ns2" ],
			"fronts"           => [ "front1" ],
			"nameservers:vars" => ansible_group_vars,
			"fronts:vars"      => ansible_group_vars,
		}
	end

end

