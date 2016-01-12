#
# Cookbook Name:: rexbackup
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
include_recipe 'rexden::ark_server'
include_recipe 'rexbackup::crashplan'
