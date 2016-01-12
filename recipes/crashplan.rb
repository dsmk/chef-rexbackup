#
# Cookbook Name:: rexbackup
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

include_recipe 'rexcore::_graphical'
include_recipe 'sysctl::default'

%w( xorg-x11-apps xorg-x11-xauth ).each do |pkg|
  package pkg
end

sysctl_param 'fs.inotify.max_user_watches' do
  value '1048576'
end

remote_file "/usr/local/crashplan.tar.gz" do
  source node['rexbackup']['crashplan_url'] 
  checksum node['rexbackup']['crashplan_checksum']
  user 'root'
  group 'root'
end

execute 'untar_crashplan' do
  cwd '/usr/local'
  command '/bin/tar -xzvf /usr/local/crashplan.tar.gz'
  not_if { File.exists?("/usr/local/crashplan-install/install.sh") }
end

cookbook_file "/usr/local/crashplan-install/auto_install.sh" do
  source "auto_install.sh"
  user "root"
  group "root"
  mode "0755"
end

template '/usr/local/crashplan-install/auto_install.defaults' do
  source 'auto_install.defaults.erb'
  user 'root'
  group 'root'
  mode '0644'
end

execute 'install-crashplan' do
  cwd '/usr/local/crashplan-install'
  command "./auto_install.sh >/var/log/auto_crashplan_install.log 2>&1"
  not_if { File.exists?("/var/log/auto_crashplan_install.log") }
end

