#
# Cookbook Name:: collegestar_org
# Recipe:: default
#
# Copyright (c) 2016 Joel, All Rights Reserved.

include_recipe 'collegestar_org::base'
include_recipe 'collegestar_org::database'
include_recipe 'collegestar_org::webserver'
include_recipe 'collegestar_org::appserver'
