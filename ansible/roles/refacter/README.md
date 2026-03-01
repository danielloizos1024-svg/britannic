Refacter
=========

Add and remove admin and standard users and their SSH keys

Requirements
------------

A management account, configured with passwordless access, and NOPASSWD sudo rights

e.g.
/etc/sudoers.d/wheel
%wheel ALL=(ALL) NOPASSWD:ALL

/etc/sudoers.d/sudo
%sudo ALL=(ALL) NOPASSWD:ALL



Role Variables
--------------
name: name of user
state: "present" for adding an account or "absent" for account removal
admin: "yes" for when adding administrators, "no" for when adding standard users
pubkey: user's public key 

Dependencies
------------
None

Example Playbookm
----------------

- name: bootstrap users
  hosts: all
  roles:
  - refacter
  vars:
    user:
    - { name: "admin", state: "present", admin: "yes", pubkey: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBCxQlhNwgYST8JzpPKKjczgEVtL+rPC824o2gghOMN dpl@redfern01.dlws.io" }
    - { name: "standard", state: "present", admin: "no", pubkey: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBCxQlhNwgYST8JzpPKKjczgEVtL+rPC824o2gghOMN dpl@redfern01.dlws.io" }


License
-------

BSD

Author Information
------------------

daniel.loizos@gmail.com
