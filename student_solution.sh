#!/bin/bash

# SELinux Access Denial Practical
# Student Name:Brundha S
# Register Number:1U24IT135

echo "===== SELinux Status ====="
getenforce
sestatus

echo "===== Creating Web Directory ====="
sudo mkdir -p /var/www/html/selinux_practical
echo "===== Creating HTML File ====="
echo "<html><body><h1>SELinux Practical Test</h1></body></html>" | \
sudo tee /var/www/html/selinux_practical/index.html > /dev/null

echo "===== Setting Linux Permissions ====="
sudo chmod 755 /var/www/html/selinux_practical
sudo chmod 644 /var/www/html/selinux_practical/index.html


echo "===== Checking Initial Context ====="
ls -Zd /var/www/html/selinux_practical
ls -Z /var/www/html/selinux_practical/index.html

echo "===== Assigning Wrong SELinux Context ====="
sudo chcon -t user_home_t /var/www/html/selinux_practical/index.html

echo "===== Checking Wrong Context ====="
ls -Z /var/www/html/selinux_practical/index.html

echo "===== Checking AVC Denials ====="
sudo ausearch -m AVC -ts recent

echo "===== Correcting SELinux Context ====="
sudo restorecon -v /var/www/html/selinux_practical/index.html

echo "===== Checking Correct Context ====="
ls -Z /var/www/html/selinux_practical/index.html

echo "===== Practical Completed ====="
