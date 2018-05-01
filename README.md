# Weirdly Ansible

A utility repository to quickly provision various server installations using 
[Ansible](http://docs.ansible.com/). **Please Note**: these provisioning tools do not
enable firewall security on the servers being provisioned because this relies on knowledge of 
the chosen network infrastructure. Please be sure to configure and enable the firewalls for your 
servers yourself.

Once you've cloned this repository to your local machine you will need to run `make joinfiles` to stitch
large files back together before running any of the vagrant commands or playbooks. GitHub has a 50MB limit
on files in the repository so Kibana and OpenAM install files have been split into smaller files that need
to be joined before they can be used.



## Requirements

To run the ansible playbooks an installation of ansible is required. This can be easily installed using 
the python package manager `pip`. Full instructions can be found [here](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-pip)

```bash
# if you don't have pip installed you can use this first:
sudo easy_install pip

# to install ansible use:
sudo pip install ansible

# or on mavericks:
sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments pip install ansible
```



## Vagrant

This repository has also been endowed with a vagrant implementation for development purposes. This requires 
both Vagrant and VirtualBox to be installed on your development system but allows you to start a virtual 
machine with the needed software installed with a single command. The commands for each of the playbooks is 
listed below with their relevant documentation.

To install vagrant, download the relevant package from the [vagrant download page](https://www.vagrantup.com/downloads.html)
and VirtualBox from the [virtualbox download page](https://www.virtualbox.org/wiki/Downloads).



## Usage
Multiple playbooks have been provided for the various software requirements of our reference architecture.

* Open-AM - open-am.yml
* Open-IG - open-ig.yml
* ElasticSearch - elasticsearch.yml
* Kibana - kibana.yml

To set a server up with one of these use the command below replacing the {server_address} and {playbook} 
with their corresponding values. Each playbook has some limited configuration options which defer to 
reasonable defaults when these are omitted. 
```
ansible-playbook -i {server_address} {playbook}.yml [--extra-vars '{"key":"value",...}']
```
Configuration options may be overridden using the `--extra-vars` option when running the playbook.



## Open-AM

#### Installs
* Java 8
* Tomcat v9.0.7
* ForgeRock Open AM v5.5.1 

#### Configuration values (showing defaults)
```
tomcat_service_name : "tomcat"
tomcat_user         : "tomcat"
tomcat_group        : "tomcat"
tomcat_parent       : "/opt"
tomcat_admin_user   : "admin"
tomcat_admin_pass   : "admin"
tomcat_admin_port   : "8005"
tomcat_http_port    : "8080"
tomcat_https_port   : "8443"
tomcat_ajp_port     : "8009"
```

#### Vagrant
Run `vagrant up am` to create the VM and run the ansible relevant playbooks. Once complete you will 
be able to access the open-am installation in your browser at `http://localhost:8080/am/`. 



## Open-IG

#### Installs
* Java 8
* Tomcat v9.0.7
* ForgeRock Open IG v5.5.0
 
#### Configuration values (showing defaults)
```
tomcat_service_name : "tomcat"
tomcat_user         : "tomcat"
tomcat_group        : "tomcat"
tomcat_parent       : "/opt"
tomcat_admin_user   : "admin"
tomcat_admin_pass   : "admin"
tomcat_admin_port   : "8005"
tomcat_http_port    : "8080"
tomcat_https_port   : "8443"
tomcat_ajp_port     : "8009"
```

#### Vagrant
Run `vagrant up ig` to create the VM and run the ansible relevant playbooks. Once complete you will 
be able to access the open-ig installation in your browser at `http://localhost:8080/ig/`. It does 
however require some configuration before it's usefull.



## ElasticSearch

#### Installs
* Java 8
* ElasticSearch v6.2.4

#### Configuration values (showing defaults)
```
elasticsearch_service_name  : "elasticsearch"
elasticsearch_cluster_name  : "cluster-a"
elasticsearch_node_name     : "{{ elasticsearch_cluster_name }}-node-1"
elasticsearch_version       : "6.2.4"
elasticsearch_user          : "elasticsearch"
elasticsearch_group         : "elasticsearch"
elasticsearch_parent        : "/opt"
elasticsearch_rest_port     : "9200"
```

#### Vagrant
Run `vagrant up es` to create the VM and run the ansible relevant playbooks. Once complete you will 
be able to access elasticsearch server at `http://localhost:9200/`.



## Kibana

#### Installs
* Kibana v6.2.4

#### Configuration values (showing defaults)
```
kibana_service_name     : "kibana"
kibana_version          : "6.2.4-linux-x86_64"
kibana_user             : "kibana"
kibana_group            : "kibana"
kibana_parent           : "/opt"
kibana_port             : "5601"

elasticsearch_url       : "http://localhost:9200"
```

#### Vagrant
Run `vagrant up kb` to create the VM and run the ansible relevant playbooks. Once complete you will 
be able to access kibana server at `http://localhost:5601/`. Kibana will by default connect to your 
locally running (or port mapped from running `vagrant up es`) elasticsearch.  
