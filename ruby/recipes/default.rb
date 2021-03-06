#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2011-2012, Beijing Menglifang Network Science and Technology
# Co.,Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'rvm'

# Install the required packages for Ruby
interpreter = node['ruby']['interpreter']

node['ruby'][interpreter]['required_packages'].each do |pkg|
  package pkg
end

bash 'install ruby' do
  code <<-EOH
    source #{node['rvm']['global'] ? '/usr/local/rvm' : "/home/#{node.current_user}/.rvm"}/scripts/rvm
    rvm install #{node['ruby']['version']}
  EOH
  user node['rvm']['global'] ? 'root' : node.current_user
end
