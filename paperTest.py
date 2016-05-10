import os
USER = "root"

fp = open("hostfile")
ip_list = fp.readlines()

for ip in ip_list:
    os.system("ssh %s@%s apt-get update"%(USER,ip.strip().split(":")[0]))
    print "ssh %s@%s apt-get update"%(USER,ip.strip())
for ip in ip_list:
    os.system("ssh %s@%s apt-get install -y python-pip python-numpy mpich python-dev git"%(USER,ip.strip().split(":")[0]))
    print "ssh %s@%s apt-get install -y python-pip python-numpy mpich python-dev git"%(USER,ip.strip().split(":")[0])
for ip in ip_list:
    os.system("ssh %s@%s pip install mpi4py"%(USER,ip.strip().split(":")[0]))
    print "ssh %s@%s pip install mpi4py"%(USER,ip.strip().split(":")[0])    
for ip in ip_list:
    os.system("ssh %s@%s git clone https://github.com/linuxfl/paperTest.git"%(USER,ip.strip().split(":")[0]))
    print "ssh %s@%s git clone https://github.com/linuxfl/paperTest.git"%(USER,ip.strip().split(":")[0])
print "Success!!!"
