#Installing apache package : 
package 'httpd' do
	action :install
end
#Enabling & starting Service apache : 
service 'httpd' do
	action [:enable, :start]
end
#Creating Group : 
group "dba" do
     action :create
end
group "unixgrp" do
      action :create
end
group "webgrp" do
      action :create 
end
#Creating UNIX User : 
user "unixadm1" do
     comment "A unix user"
     uid 1000
     gid "unixgrp"
     home "/home/unixadm1"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end

     directory "/home/unixadm1/" do
	owner "unixadm1"
        group "unixgrp"
        mode "0744"
        action :create
        recursive true
end
user "unixadm2" do
     comment "A unix user"
     uid 1001
     gid "unixgrp"
     home "/home/unixadm2"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end

     directory "/home/unixadm2/" do
        owner "unixadm2"
        group "unixgrp"
        mode "0744"
        action :create
        recursive true
end
user "unixadm3" do
     comment "A unix user"
     uid 1002
     gid "unixgrp"
     home "/home/unixadm3"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end

    directory "/home/unixadm3/" do
        owner "unixadm3"
        group "unixgrp"
        mode "0744"
        action :create
        recursive true
end
#Creating WEB User : 
user "webuser1" do
     comment "A web user"
     uid 1003
     gid "webgrp"
     home "/home/webuser1"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end

     directory "/home/webuser1/" do
        owner "webuser1"
        group "webgrp"
        mode "0744"
        action :create
        recursive true
end
user "webuser2" do
     comment "A web user"
     uid 1004
     gid "webgrp"
     home "/home/webuser2"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end

     directory "/home/webuser2/" do
        owner "webuser2"
        group "webgrp"
        mode "0744"
        action :create
        recursive true
end
user "webuser3" do
     comment "A web user"
     uid 1005
     gid "webgrp"
     home "/home/webuser3"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end
     directory "/home/webuser3/" do
        owner "webuser3"
        group "webgrp"
        mode "0744"
        action :create
        recursive true
end
#Creating WEB User :
user "oracle1" do
     comment "A oracle user"
     uid 1006
     gid "dba"
     home "/home/oracle1"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end
     directory "/home/oracle1/" do
        owner "oracle1"
        group "dba"
        mode "0744"
        action :create
        recursive true
end
user "oracle2" do
     comment "A oracle user"
     uid 1007
     gid "dba"
     home "/home/oracle2"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end
     directory "/home/oracle2/" do
        owner "oracle1"
        group "dba"
        mode "0744"
        action :create
        recursive true
end
user "oracle3" do
     comment "A oracle user"
     uid 1008
     gid "dba"
     home "/home/oracle3"
     shell "/bin/bash"
     password "$1$Av3xOLpF$oQJj/bwH8xtCo32lys1QT1"
end
     directory "/home/oracle3/" do
        owner "oracle3"
        group "dba"
        mode "0744"
        action :create
        recursive true
end
#install ntp package :
package "ntp" do
	action :install
end
service "ntpd" do
	action [:enable, :start]
end
execute 'command-test' do 
      command '/usr/bin/sed -i "s/^server/#server/g" /etc/ntp.conf'
      command '/usr/bin/echo "utcnist.colorado.edu iburst" >>/etc/ntp.conf'
      only_if 'test -r /etc/ntp.conf'
end
execute 'command-test' do
#      command '/usr/bin/sed -i "s/^server/#server/g" /etc/ntp.conf'
      command '/usr/bin/echo "utcnist2.colorado.edu iburst" >>/etc/ntp.conf'
      only_if 'test -r /etc/ntp.conf'
end
#check & install os based package : 
if node['platform_family'] == "rhel"
       package ="httpd"
elsif node['platform_family'] == "ubuntu"
       package ="apache2"
end
package 'apache2' do
	package_name package
	action :install  
end
service 'apache2' do
 	service_name 'httpd'
	action [:enable, :start]
end

#Update /etc/hosts file
execute 'command-test' do 
	command '/usr/bin/echo "192.168.1.20 test.veritis.com test" >>/etc/hosts'
	only_if 'test -r /etc/hosts'
end 
#update nameserrver on /etc/resolv.conf
execute 'command-test' do
	command '/usr/bin/echo "nameserver 8.8.8.8" >>/etc/resolv.conf'
	only_if 'test -r /etc/resolv.conf'
end
#creating repo
execute 'command-test' do
	command '/usr/bin/echo "[testrepo]" >>/etc/yum.repos.d/test.repo'
end
execute 'command-test' do
	command '/usr/bin/echo "name=local repo of rhel" >>/etc/yum.repos.d/test.repo'
end
execute 'command-test' do
        command '/usr/bin/echo "baseurl=file:///mnt" >>/etc/yum.repos.d/test.repo'
end
execute 'command-test' do
        command '/usr/bin/echo "gpgcheck=0" >>/etc/yum.repos.d/test.repo'
end
execute 'command-test' do
        command '/usr/bin/echo "enabled=1" >>/etc/yum.repos.d/test.repo'
end
#deleting user : unixadm3
user "unixadm3" do
	action :remove
end

    directory "/home/unixadm3/" do
	action :delete
end
#printing number 10, creating file /temp/bashout.txt & should be idempotent : 
(1..10).each { |i| puts i }

execute 'command-test' do
	command '/usr/bin/touch /tmp/bashout.txt'
not_if 'test -z /tmp/bashout.txt'
end
# cronjob everyday @11am
package 'cronie' do
 	action :install
end
service 'crond' do
	action [:enable, :start]
end

cron 'recipe:node' do 
	action :create
	hour '11'
	user 'root'
	command '/root/script/chefcron'
end
