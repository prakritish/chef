#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
if platform?("centos") 
    remote_file "#{Chef::Config[:file_cache_path]}/mysql-community-release-el7-5.noarch.rpm" do
        source "http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm"
        action :create
    end

    rpm_package "mysql-community" do
        source "#{Chef::Config[:file_cache_path]}/mysql-community-release-el7-5.noarch.rpm"
        action :install
    end
    execute "yum update -y"
end

package "mysql" do
    package_name "mysql-server"
    action :install
end
