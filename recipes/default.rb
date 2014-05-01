#
# Cookbook Name:: mailcatcher
# Recipe:: default
#
# Copyright 2014, Vubeology LLC
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"


# Install sqlite3-dev lib dependency
package "libsqlite3-dev"

# Install mailcatcher gem
gem_package "mailcatcher"

# Make MailCatcher start on subsequent machine boots
template '/etc/init.d/mailcatcher' do
	source	'init_d.mailcatcher.erb'
	owner	'root'
	group	'root'
	mode	'0755'
end

# Shut down exim and stop it running in the future
bash "halt-exim" do
    code "/etc/init.d/exim4 stop; chmod 644 /etc/init.d/exim4"
    only_if "ps auxgw | grep -v grep | grep exim4"
end

# Start MailCatcher during provision phase
bash "mailcatcher" do
    code "/etc/init.d/mailcatcher start"
    not_if "ps ax | grep -v grep | grep mailcatcher"
end

# Configure PHP to send emails to mailcatcher
template "/etc/php5/conf.d/mailcatcher.ini" do
    source	"mailcatcher.ini.erb"
    owner	"root"
    group	"root"
    mode	"0644"
    action	:create
    notifies :restart, resources("service[apache2]"), :delayed
end
