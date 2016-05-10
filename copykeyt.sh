#!/bin/bash
user="fangling"
password="0000"

for p in $(cat hostfile)
do
ip=$(echo "$p"|cut -f1 -d":")
expect <<EOF
spawn scp $user@$ip:/home/$user/.ssh/id_rsa.pub /home/$user/.ssh/id_rsa.pub.$ip
expect {
      "yes/no" { send "yes\r";exp_continue}
      "password:" {send "$password\r";exp_continue}
}
EOF
done

for p in $(cat hostfile)
do
ip=$(echo "$p"|cut -f1 -d":")
    cat /home/$user/.ssh/id_rsa.pub.$ip >> /home/$user/.ssh/authorized_keys
    rm /home/$user/.ssh/id_rsa.pub.$ip
done

for p in $(cat hostfile)
do
ip=$(echo "$p"|cut -f1 -d":")
expect <<EOF
spawn scp /home/$user/.ssh/authorized_keys $user@$ip:/home/$user/.ssh/
expect {
      "yes/no" { send "yes\r";exp_continue}
      "password:" {send "$password\r";exp_continue}
}
EOF
done
