#!/bin/bash

# SELinux Access Denial Practical
# Student Name:brundhas
# Register Number:1u24it135

echo "===== SELinux Status ====="
getenforce
sestatus


echo "===== Creating Web Directory ====="
sudo mkdir -p /myweb

echo "===== Creating HTML File ====="
echo "<html><body><h1>Hello SELinux</h1></body></html>" | sudo tee /myweb/index.html > /dev/null

echo "===== Setting Linux Permissions ====="
sudo chmod 755 /myweb
sudo chmod 644 /myweb/index.html

echo "===== Checking Initial Context ====="
ls -lZ /myweb/index.html

echo "===== Assigning Wrong SELinux Context ====="
sudo chcon -t user_home_t /myweb/index.html

echo "===== Checking Wrong Context ====="
ls -lZ /myweb/index.html

echo "===== Checking AVC Denials ====="
sudo ausearch -m AVC -ts recent 2>/dev/null

echo "===== Correcting SELinux Context ====="
sudo restorecon -v /myweb/index.html

echo "===== Checking Correct Context ====="
ls -lZ /myweb/index.html

echo "===== Practical Completed ====="
