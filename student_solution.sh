#!/bin/bash

# SELinux Access Denial Practical
# Student Name:
# Register Number:

echo "===== SELinux Status ====="

getenforce
sestatus

echo "===== Creating Web Directory ====="

sudo mkdir -p /myweb

echo "===== Creating HTML File ====="

echo "Hello SELinux" | sudo tee /myweb/index.html

echo "===== Setting Linux Permissions ====="

sudo chmod 755 /myweb
sudo chmod 644 /myweb/index.html

echo "===== Checking Initial Context ====="

ls -Zd /myweb
ls -Z /myweb/index.html

echo "===== Assigning Wrong SELinux Context ====="

sudo chcon -t default_t /myweb/index.html

echo "===== Checking Wrong Context ====="

ls -Z /myweb/index.html

echo "===== Checking AVC Denials ====="

sudo ausearch -m AVC,USER_AVC -ts recent

echo "===== Correcting SELinux Context ====="

sudo chcon -t httpd_sys_content_t /myweb/index.html

echo "===== Checking Correct Context ====="

ls -Z /myweb/index.html

echo "===== Practical Completed ====="


