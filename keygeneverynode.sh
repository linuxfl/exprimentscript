#!/bin/bash
user="fangling"
password="0000"

for ip in $(cat ip.list)
do
expect <<EOF
spawn ssh $user@$ip "ssh-keygen -t rsa" 
expect {
      "yes/no" { send "yes\r";exp_continue}
      "password:" {send "$password\r";exp_continue}
      "Enter file in which to save the key*" {send "\r";exp_continue}
      "Overwrite*" {send "y\r";exp_continue}
      "Enter passphrase*" {send "\r";exp_continue}
      "Enter same passphrase again:" {send "\r";exp_continue}
}
EOF
done
