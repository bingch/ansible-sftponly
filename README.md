Role Name
=========

Roles to add sftp only user

Requirements
------------

Use shell-user role (https://github.com/bingch/ansible-shell-user) to handle actual user creation

Role Variables
<pre>
--------------
sfponly_config: main list holds all sftp user's conf, each element can have:
  sftp_root: optional, default to /home/sftponly, it must be owned by root
  sftp_user: user owns the download/upload folder, if defined it must be member of ftp_users list (see below)
  sftp_group: group used for "Match Group" config stanza of sshd
  sftp_other_dirs: optional, subdirs/links inside sftp user's chroot folder that needs special ownership/group or permisson mode
  sftp_users: optional, a list of user meta files (see shell-user role for more details
</pre>
Dependencies
------------
- tcpwrapper
- shell-user

Example Playbook
----------------

- name: Add sftp only user to servers
  hosts: all
  become: yes

  tasks:
    - name: Add sftp only user to servers
      include_role:
        name: sftponly
      vars:
        sftponly_config:
          - sftp_root: /var/sftp
            sftp_user: john
            sftp_other_dirs: 
               - path: /var/sftp/download
                 owner: john
            sftp_users:
              - john.yml

License
-------

GPLv3

Author Information
------------------

bingch
https://github.com/bingch