file '/etc/motd' do
	content "Welcome to #{node['fqdn']}!\n"
end
