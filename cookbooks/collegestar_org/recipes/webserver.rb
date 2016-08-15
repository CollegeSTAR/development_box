#
# Cookbook Name:: collegestar_org
# Recipe:: webserver
#
# Copyright (c) 2016 College STAR, All Rights Reserved.

include_recipe 'apt'
include_recipe 'nginx'

template '/etc/nginx/sites-available/default' do
  source 'nginx_default_site.erb'
  mode '0644'
  owner 'root'
  group 'root'
end
