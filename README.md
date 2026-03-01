# britannic
Scripting Challenges

Thanks for accepting my application, Included in this repo are files for 

## Scripting Challenges 
### Scripting Challenge1.

The script takes an md5 hash of /etc/password and stores it in /tmp/file-+%Y%m%d-%H%M%S. The file is compared with the one previously generated. Wen the files are the same, we are told, and when the files differ, we are told then too!

#### Usage
```
copy check_password.sh to a location of your choosing
chmod +x check_password.sh 
chown root:root check_password.sh 
sudo crontab -e
```

Copy the crontab file (included) into it (keeping any other jobs, and not overwriting them). Modify the path in the crontab to reflect where you stored the check_password.sh file. Cron is set to run every 15 minutes. When /etc/passwd changes, /var/log/cron will show the mmessage "/etc/passwd changed".

### Scripting Challenge2.

I ran out of time, and did not manage to get this far. With more time, I would have investigated "docker events" and written something like

```
docker events | grep <container>
```

## Ansible Role
Please look in the ansible folder for the files below. You will find
1. an ansible.cfg file. This specifies the need for an ansible user, the name of the inventory file and the prescribed location of the roles folder.
2. an inventory file. Use this to store hostnames or IP addresses (depending on your DNS configuration)
3. a playbook called "refacter.yml". This playbook should be used to run the role "refacter"
4. roles/refacter - the role that does the heavy lifting

### goal
* the goal was to provide a role that could be used to manage (add/remove) users and their SSH keys on Debian (and other) server types.

### requirements
* servers will need an ansible user configured on them, with sudo/wheel membership, and NOPASSWD sudoers settings. I read the "asumptions" section which seenmed to indicate these requirements would be met. 
* servers will need putty3 installed

### testing
* this role was tested on a debian server and a rocky server

### role usage
```
git clone https://github.com/danielloizos1024-svg/britannic
cd ansible
```
configure the inventory with your managed hosts (making sure they are configured above with an ansible user)
configure refacter.yml, considering the following variables
* name: username
* state: present/absent
* admin: yes/no, governs sudo/wheel group membership
* pubkey: insert user's public ssh key

```
    - { name: "standard", state: "present", admin: "no", pubkey: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBCxQlhNwgYST8JzpPKKjczgEVtL+rPC824o2gghOMN dpl@redfern01.dlws.io" }

ansible-playbook refacter.yml -i path/to/inventory
```
### design
1. users are managed with refacter.yml, not inside the role. This allows for easy role reuse. reflecter.yml could be copied many times, and used for different servers or groups.

2. the role creates groups based on OS, which are detected using Ansible facts. Admin users can be defined, as described above:
  a) the 'wheel' group for RHEL servers. A sudoers.d/wheel file is created giving NOPASSWD acces
  b) 'sudo' for debian servers.  A sudoers.d/sudo file is created giving NOPASSWD acces
3. A 'users' group for non-admins is also given, by default
4. a README is included with the role too.


## Terraform
I did not get as far as I would have liked with Terraform. My terraform scripts can
* pull grafana and prometheus docker images, build a network and build both containers
* networking works
* add an organization to Grafana container, create a folder, create (but not populate a dashboard)
* add prometheus as a data source.

I was unable to create or use someone else's dashboard, or create alerts


### In the repo
see the terraform folder in my repo for the following files:
* containers.tf
* images.tf
* network.tf
* provider.tf

### To build the environment
* copy files to server
```
yum -y install epel-release
yum -y install terraform
terraform init
terraform apply, _twice_
```

### Known bug
With more time and research I think I could figure out how to pause terraform apply, in order to give the whole process time to apply. The bug is that it takes terraform apply two attempts to get the environment up and running

```
╷
│ Error: Post "http://grafana.dlws.io:3000/api/orgs": dial tcp 192.168.122.10:3000: connect: connection refused
│ 
│   with grafana_organization.dlws_io,
│   on provider.tf line 26, in resource "grafana_organization" "dlws_io":
│   26: resource "grafana_organization" "dlws_io" {
│ 
╵
╷
│ Error: Post "http://grafana.dlws.io:3000/api/datasources": dial tcp 192.168.122.10:3000: connect: connection refused
│ 
│   with grafana_data_source.prometheus,
│   on provider.tf line 46, in resource "grafana_data_source" "prometheus":
│   46: resource "grafana_data_source" "prometheus" {
│ 
╵
[dpl1@terraform01 ~]$
```
