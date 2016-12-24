#
# Cookbook Name:: localusers
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

search(:users, "*:*").each do |data|
    user data["id"] do
        comment data["comment"]
        uid data["uid"]
        home data["home"]
        shell data["shell"]
        password data["password"]
    end
end
include_recipe "localusers::groups"
