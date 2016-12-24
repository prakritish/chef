#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# Install and start apache
if node['platform_family'] == "rhel"
	package = "httpd"
elsif node['platform_family'] == "debian"
	package = "apache2"
end

if node["platform"] == "ubuntu"
    execute "apt-get update -y"
end

package 'apache2' do
	package_name node["apache2"]["package"]
	action :install
end

node["apache"]["sites"].each do |sitename, data|
    document_root = "/content/sites/#{sitename}"
    directory document_root do
        mode "0755"
        recursive true
        action :create
    end

    if node["platform"] == "ubuntu"
        template_location = "/etc/apache2/sites-enabled/#{sitename}.conf"
        port_config = "/etc/apache2/ports.conf"
    elsif node["platform"] == "centos"
        template_location = "/etc/httpd/conf.d/#{sitename}.conf"
        port_config = "/etc/httpd/conf/httpd.conf"
    end

    template template_location do
        source "vhost.erb"
        mode "0644"
        variables(
            :document_root => document_root,
            :port => data["port"],
            :domain => data["domain"]
        )
        notifies :restart, "service[apache2]"
    end
    ruby_block "#{port_config} #{sitename}" do
        block do
            fe = Chef::Util::FileEdit::new(port_config)
            fe.insert_line_if_no_match("Listen #{data['port']}", "Listen #{data['port']}")
            fe.write_file
        end
    end

    template "/content/sites/#{sitename}/index.html" do
        source "index.html.erb"
        mode "0644"
        variables(
            :site_title => data["site_title"],
            :coming_soon => "Coming Soon!",
            :author_name => node["author"]["name"]
        )
    end
end

execute "rm -f /etc/httpd/conf.d/welcome.conf" do
    only_if do
        File.exists?("/etc/httpd/conf.d/welcome.conf")
    end
    notifies :restart, "service[apache2]"
end

execute "rm -f /etc/httpd/conf.d/README" do
    only_if do
        File.exists?("/etc/httpd/conf.d/README")
    end
    notifies :restart, "service[apache2]"
end

service 'apache2' do
	service_name node["apache2"]["package"]
	action [:start, :enable]
end

include_recipe "php::default"
