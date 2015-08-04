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
role2pkg = {
  'mapr_consul_zookeeper' => true,
  'mapr_consul_cldb' => 'mapr-cldb',
  'mapr_consul_fileserver' => 'mapr-fileserver',
  'mapr_consul_nfs' => true,
  'mapr_consul_resourcemanager' => 'mapr-resourcemanager',
  'mapr_consul_nodemanager' => 'mapr-nodemanager',
  'mapr_consul_historyserver' => 'mapr-historyserver',
  'mapr_consul_webserver' => 'mapr-webserver',
  'mapr_consul_metrics' => 'mapr-metrics',
  'mapr_consul_pig' => 'mapr-pig',
  'mapr_consul_hive' => 'mapr-hive',
  #'mapr_consul_hbase_master' => 'mapr-hbase-master',
  #'mapr_consul_hbase_regionserver' => 'mapr-hbase-regionserver',
  #'mapr_consul_hbase_client' => 'mapr-hbase-internal',
}

role2pkg.each do |role_name, pkg_name|
  if node.role?(role_name)
    if pkg_name == true
      # this package has dedicated recipe
      include_recipe role_name.sub('mapr_consul_', 'mapr_consul::')
    else
      if role_name == 'mapr_consul_historyserver' and node[:facet_index] != 0
        # only one history server is needed
        next
      end
      package pkg_name
    end
  end
end

# start the warden
service 'mapr-warden' do
  only_if { File.exist?('/opt/mapr/initscripts/mapr-warden') }
  action [:enable, :start]
end

# Install the consul client
include_recipe "mapr_consul::consul_client"
