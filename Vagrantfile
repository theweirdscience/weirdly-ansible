Vagrant.configure("2") do |config|

    # standalone Ubuntu server
    config.vm.define "ubuntu" do |u|
        u.vm.box = "bento/ubuntu-18.04"
    end

    # ForgeRock Open AM
    config.vm.define "am" do |am|
        am.vm.box = "bento/ubuntu-18.04"
        am.vm.network "forwarded_port", guest: 8080, host: 8080
        #am.vm.network "forwarded_port", guest: 8005, host: 8005
        #am.vm.network "forwarded_port", guest: 8009, host: 8009
        #am.vm.network "forwarded_port", guest: 8443, host: 8443
        am.vm.provision "ansible" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "open-am.yml"
        end
    end

    # ForgeRock Open IG
    config.vm.define "ig" do |ig|
        ig.vm.box = "bento/ubuntu-18.04"
        ig.vm.network "forwarded_port", guest: 8080, host: 9080
        #ig.vm.network "forwarded_port", guest: 8005, host: 9005
        #ig.vm.network "forwarded_port", guest: 8009, host: 9009
        #ig.vm.network "forwarded_port", guest: 8443, host: 9443
        ig.vm.provision "ansible" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "open-ig.yml"
        end
    end

    # Elastic Search
    config.vm.define "es" do |es|
        es.vm.box = "bento/ubuntu-18.04"
        es.vm.network "forwarded_port", guest: 9200, host: 9200
        es.vm.network "forwarded_port", guest: 9300, host: 9300
        es.vm.provision "ansible" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "elasticsearch.yml"
        end
    end

    # Elastic Kibana
    config.vm.define "kb" do |kb|
        kb.vm.box = "bento/ubuntu-18.04"
        kb.vm.network "forwarded_port", guest: 5601, host: 5601
        kb.vm.provision "ansible" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.playbook = "kibana.yml"
            ansible.extra_vars = {
                "elasticsearch_url": "http://10.0.2.2:9200"
            }
        end
    end

end
