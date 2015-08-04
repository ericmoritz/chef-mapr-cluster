# install NFS utils
package 'nfs-utils'

# install RPC service
case node['platform']
when "redhat", "centos", "scientific", "oracle"
  if node['platform_version'].to_f >= 6.0
    pkg_name = 'rpcbind'
    svc_name = 'rpcbind'
  else
    pkg_name = 'portmap'
    svc_name = 'portmap'
  end
end

package pkg_name
service svc_name do
  action :start
end

package 'mapr-nfs'
