#
# Cookbook Name:: collegestar_org
# Recipe:: base
#
# Copyright (c) 2016 College STAR, All Rights Reserved.

execute "apt-get-update" do
  command "sudo apt-get update -y"
  notifies :run, 'execute[apt-get-upgrade]'
end

execute "apt-get-upgrade" do
  command "sudo apt-get upgrade -y"
  action :nothing
end
