#
# Cookbook Name:: rexbackup
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
include_recipe 'rexcore'
include_recipe 'rexcore::ark_server'
include_recipe 'rexbackup::crashplan'
