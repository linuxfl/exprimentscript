#!/bin/bash
user="root"
password="2672256ab*"

for p in $(cat hostfile)
do
ip=$(echo "$p"|cut -f1 -d":")
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

for p in $(cat hostfile)
do
ip=$(echo "$p"|cut -f1 -d":")
expect <<EOF
spawn scp $user@$ip:/root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub.$ip
expect {
      "yes/no" { send "yes\r";exp_continue}
      "password:" {send "$password\r";exp_continue}
}
EOF
done

for p in $(cat hostfile)
do
ip=$(echo "$p"|cut -f1 -d":")
    cat /root/.ssh/id_rsa.pub.$ip >> /root/.ssh/authorized_keys
    rm  /root/.ssh/id_rsa.pub.$ip
done

for p in $(cat hostfile)
do
ip=$(echo "$p"|cut -f1 -d":")
expect <<EOF
spawn scp /root/.ssh/authorized_keys $user@$ip:/root/.ssh/
expect {
      "yes/no" { send "yes\r";exp_continue}
      "password:" {send "$password\r";exp_continue}
}
EOF
done
