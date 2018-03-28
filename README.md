Role Name
=========

Roles to add sftp only user

Requirements
------------

Use shell-user role (https://github.com/bingch/ansible-shell-user) to handle actual user creation

Role Variables
<pre>
--------------
<b>sftponly_config</b>: main list holds all sftp user's conf, each element can have:
  <b>sftp_root</b>: optional, default to /home/sftponly, it must be owned by root
  <b>sftp_user</b>: user used for "Match User" config stanza of sshd, if defined it must be member of ftp_users list
  (see below)
  <b>sftp_group</b>: group used for "Match Group" config stanza of sshd, should either use <b>sftp_user</b> or this one
  <b>sftp_other_dirs</b>: optional, subdirs/links inside sftp user's chroot folder that needs special 
  ownership/group or permisson mode
  <b>sftp_users</b>: optional, a list of user meta files (see shell-user role for more details)
</pre>
Dependencies
------------
- tcpwrapper
- shell-user

Example Playbook
----------------
<pre>
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
</pre>
License
-------

GPLv3

Author Information
------------------

bingch
https://github.com/bingch
