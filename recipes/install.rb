#
#   Portions Copyright (c) 2012-2014 VMware, Inc. All Rights Reserved.
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# Doc reference http://doc.mapr.com/display/MapR/Planning+the+Cluster

include_recipe 'mapr_consul::prereqs'

## Install MapR packages specified by roles
# mapping of role to package. 'true' means this role has a corresponding recipe.
group node['mapr_consul']['group'] do
  gid node['mapr_consul']['gid']
end

user node['mapr_consul']['user'] do
  uid node['mapr_consul']['uid']
  gid node['mapr_consul']['gid']
  shell '/bin/bash'
  home "/home/#{node['mapr_consul']['user']}"
end

node['mapr_consul']['packages'].each do |key, info|
  role_name = info["role"]
  pkg_name = info["pkg_name"]
  service_name = info["pkg_name"]

  if node.role?(role_name)
    if info["recipe"]
      # this package has dedicated recipe
      include_recipe info["recipe"]
    else
      package pkg_name
    end

    info["services"].each do |x|
      print "consul_service_def: #{x}"
      consul_service_def x['name'] do |r|
        tags (x['tags'] || []) + [node['mapr_consul']['clustername']]
        port x['port']
        check(
          interval: '10s',
          script: "service #{x['name']} status"
        )
      end

      if x['start']
        service x['name'] do
          action [:enable, :start]
        end
      end
    end
  end
end


# watch the warden
if File.exist?('/opt/mapr/initscripts/mapr-warden')
  consul_service_def "mapr_warden" do
    tags [node['mapr_consul']['clustername']]
    check(
      interval: '10s',
      script: "service mapr-warden status"
    )
  end
end

# render the template for the configure script
cookbook_file "/opt/mapr/server/mapr_consul_configure.py" do
  source "mapr_consul_configure.py"
  mode "755"
  owner "root"
  group "root"
end

template "/opt/mapr/contrib/mapr_consul.json.ctempl" do
  source "mapr_consul.json.ctempl.erb"
  owner "root"
  group "root"
  mode '0644'
  variables({
              "clustername" => node["mapr_consul"]["clustername"]
            })
end

consul_template_config 'mapr_consul.json' do
  templates [{
               source: '/opt/mapr/contrib/mapr_consul.json.ctempl',
               destination: '/opt/mapr/conf/mapr_consul.json',
             }]
end

service "consul" do
  action [:enable, :start, :restart]
end

service "consul-template" do
  action [:enable, :start, :restart]
end
