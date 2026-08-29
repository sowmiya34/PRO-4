#!/bin/bash

echo "========================================"
echo " SELinux Practical - Command Validation"
echo "========================================"

FILE="student_solution.sh"

if [ ! -f "$FILE" ]; then
    echo "FAIL: student_solution.sh not found"
    exit 1
fi

MARKS=0

check_command() {
    if grep -Fq "$1" "$FILE"; then
        echo "PASS: $1"
        MARKS=$((MARKS+1))
    else
        echo "FAIL: $1"
    fi
}

echo
echo "Checking required commands..."
echo

check_command "getenforce"
check_command "sestatus"
check_command "mkdir -p /myweb"
check_command "index.html"
check_command "chmod 755 /myweb"
check_command "chmod 644 /myweb/index.html"
check_command "ls -Z /myweb/index.html"
check_command "chcon -t default_t /myweb/index.html"
check_command "ausearch -m AVC,USER_AVC -ts recent"
check_command "chcon -t httpd_sys_content_t /myweb/index.html"

echo
echo "========================================"
echo "Marks: $MARKS / 10"
echo "========================================"

if [ "$MARKS" -ge 8 ]; then
    echo "RESULT: PASS"
    exit 0
else
    echo "RESULT: FAIL"
    exit 1
fi
