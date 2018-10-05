
# Create unix group
#*********************************************************
['dba','unixgrp','webgrp'].each do |grp|
	group "#{grp}" do
		action :create
	end
end

# Create users
#*********************************************************
['oracle1', 'oracle2', 'oracle3'].each do |usr|
	user "#{usr}" do
		shell "/bin/bash"
		password "#{usr}"
	end
	directory "/home/#{usr}" do
		owner "#{usr}"
		group "dba"
		mode "0744"
		action :create
	end
end

['unixadm1', 'unixadm2', 'unixadm3'].each do |unixusr|
	user "#{unixusr}" do
		shell "/bin/bash"
		password "#{unixusr}"
	end
	directory "/home/#{unixusr}" do
		owner "#{unixusr}"
		group "unixgrp"
		mode "0744"
		action :create
	end
end

['webuser1', 'webuser2', 'webuser3'].each do |webusr|
	user "#{webusr}" do
		shell "/bin/bash"
		password "#{webusr}"
	end
	directory "/home/#{webusr}" do
		owner "#{webusr}"
		group "webgrp"
		mode "0744"
		action :create
	end
end

# Install ntp package and edit ntp.conf
#*********************************************************
package("ntp")

bash "config_ntp" do
	user "root"
	code <<-EOH
		sed -i 's/^server/#server/g' /etc/ntp.conf
		echo "server utcnist.colorado.edu iburst" >> /etc/ntp.conf
		echo "server utcnist2.colorado.edu iburst" >> /etc/ntp.conf
	EOH
end

service 'ntpd' do
	action [:start, :enable]
end

# Install apache based on os
#*********************************************************
case node['platform']
when 'ubuntu'
	apt_package "apache2" do
		action :install
	end
	service 'apache2' do
		action [:enable, :start]
	end
when 'redhat'
	package("httpd")
	service 'httpd' do
		action [:enable, :start]
	end
end

# Update /etc/hosts
#*********************************************************
bash "update_hosts" do
	user "root"
	code <<-EOH
		echo "192.168.1.20 test.veritis.com test" >> /etc/hosts
	EOH
end

# Update /etc/resolve.conf
#*********************************************************
bash "update_resolve" do
	user "root"
	code <<-EOH
		echo "nameserver 8.8.8.8" >> /etc/resolve.conf
	EOH
end

# Configure yum client
#*********************************************************
file "/etc/yum.repos.d/test.repo" do
	content ::File.open("/home/nareshdh/LearningChef/Assignment/template.repo").read
	action :create
end

# delete user unixadm3
#*********************************************************
user 'unixadm3' do
	action :remove
end
directory '/home/unixadm3' do
	action :delete
end

# bash script
#*********************************************************
bash "bash_script" do
	code <<-EOH
		for i in {1..10}
		do
			echo $i
		done
		touch /tmp/bashout.txt
	EOH
	not_if "test -f /tmp/bashout.txt"
end

# Cron job
#*********************************************************
#cron "exec_script" do
#	hour "11"
#	user "root"
#	command "/home/nareshdh/LearningChef/Assignment/bashscript"
#	not_if "test -f /tmp/bashout.txt"
#end

		
