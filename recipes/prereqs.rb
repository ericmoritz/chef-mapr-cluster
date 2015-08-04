log '\n=========== Start MapR mapr_consul::prereqs.rb =============\n'

directory '/tmp' do
  owner 'root'
  group 'root'
  mode '1777'
  action :create
end

if Mixlib::ShellOut.new('getenforce') != 'Disabled'
  execute 'Setting SeLinux to Permissive mode' do
    command 'setenforce 0'
    action :run
  end

  ruby_block 'Turn off SELinux' do
    block do
      file  = Chef::Util::FileEdit.new('/etc/selinux/config')
      file.search_file_replace_line('SELINUX=enforcing',
                                    'SELINUX=disabled')
      file.search_file_replace_line('SELINUX=enforcing',
                                    'SELINUX=disabled')
      file.write_file
    end
  end
end

package 'bash'
package 'rpcbind'
package 'dmidecode'
package 'glibc'
package 'hdparm'
package 'initscripts'
package 'iputils'
package 'irqbalance'
package 'libgcc'
package 'libstdc++'
package 'redhat-lsb-core'
package 'rpm-libs'
package 'sdparm'
package 'shadow-utils'
package 'syslinux'
package 'unzip'
package 'zip'
package 'nc'
package 'wget'
package 'git'
package 'nfs-utils'
package 'nfs-utils-lib'
package 'git'
package 'gcc'
package 'patch'
package 'dstat'
package 'lsof'

java_version = node['java']['version']

bash 'Install_java' do
  code <<-EOH
    yum -y install #{java_version}
  EOH
end

# Add JAVA_HOME to /etc/profile
ruby_block 'Set JAVA_HOME in /etc/profile' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/profile')
    file.insert_line_if_no_match("export JAVA_HOME=#{node['java']['home']}", "export JAVA_HOME=#{node['java']['home']}")
    file.insert_line_if_no_match('export EDITOR=vi', 'export EDITOR=vi')
    file.write_file
  end
end

bash 'turn_on_rpcbind' do
  code <<-EOH
    service rpcbind start
    chkconfig rpcbind on
  EOH
end

ruby_block 'Installing clush' do
  block do
    Mixlib::ShellOut.
      new('rpm -ivh https://github.com/downloads/cea-hpc/clustershell/clustershell-1.6-1.el6.noarch.rpm')
  end
end

# creating directory if it does not exist

directory '/etc/clustershell' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

bash 'uname -m' do
  code <<-EOF
  echo `uname -m`
  EOF
end

execute 'validate_host_viable' do
  command 'echo `uname -m`'
  action :run
end

ruby_block 'edit etc sysctl' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/sysctl.conf')
    file.search_file_delete_line('#MapR Values')
    file.insert_line_if_no_match('#MapR\ Values', '\n#MapR Values')
    file.search_file_delete_line('vm.swappiness')
    file.insert_line_if_no_match('vm.swappiness =', 'vm.swappiness = 0')
    file.search_file_delete_line('net.ipv4.tcp_retries2')
    file.insert_line_if_no_match('net.ipv4.tcp_retries2', 'net.ipv4.tcp_retries2 = 5')
    file.search_file_delete_line('vm.overcommit_memory')
    file.insert_line_if_no_match('vm.overcommit_memory', 'vm.overcommit_memory = 0 \n')
    file.write_file
  end
end

ruby_block 'Edit /etc/security/limits.conf' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/security/limits.conf')
    file.search_file_delete_line('mapr')
    file.search_file_delete_line('#End of')
    file.insert_line_if_no_match('mapr', 'mapr	-	nofile	64000')
    file.insert_line_if_no_match('#End of', '#End of file')
    file.write_file
  end
end

ruby_block 'Edit /etc/security/limits.d/90-nproc.conf' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/security/limits.d/90-nproc.conf')
    file.search_file_delete_line('mapr')
    file.search_file_delete_line('#End of')
    file.insert_line_if_no_match('mapr', 'mapr	-	nproc	64000')
    file.insert_line_if_no_match('#End of', '#End of file')
    file.write_file
  end
end

file '/etc/yum.repos.d/maprtech.repo' do
  content "[maprtech]
name=MapR Technologies
baseurl=http://package.mapr.com/releases/v#{node['mapr_consul']['version']}/redhat/
enabled=1
gpgcheck=0
protect=1

[maprecosystem]
name=MapR Technologies
baseurl=http://package.mapr.com/releases/ecosystem-4.x/redhat
enabled=1
gpgcheck=0
protect=1"
end

include_recipe 'ntp'
