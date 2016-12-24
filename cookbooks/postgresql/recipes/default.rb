#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# Install and start postgresql

if node['platform_family'] == "rhel"
	package = "postgresql-server"
elsif node['platform_family'] == "debian"
	package = "postgresql"
end

package 'postgresql-server' do
	package_name package
	notifies :run, 'execute[postgresql-init]', :immediately
end

execute 'postgresql-init' do
	command 'postgresql-setup initdb'
	action :nothing
end

service 'postgresql' do
	action [:enable, :start]
end
