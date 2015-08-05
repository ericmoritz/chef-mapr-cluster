default['java']['version'] = 'java-1.7.0-openjdk-devel-1.7.0.79-2.5.5.3.el6_6.x86_64'
default['java']['home'] = '/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79.x86_64/'

default['mapr_consul']['group'] = "mapr"
default['mapr_consul']['gid'] = 9000
default['mapr_consul']['user'] = "mapr"
default['mapr_consul']['uid'] = 9000

default['mapr_consul']['home'] = '/opt/mapr'
default['mapr_consul']['clustername'] = 'my_cluster'
default['mapr_consul']['version'] = '4.0.2'
default['mapr_consul']['repo_url'] = 'http//package.mapr.com/releases'

default['mapr_consul']['disk_glob'] = '/dev/sd*'
default['mapr_consul']['disk_range'] = ['/dev/sdb']

default['consul']['service_mode'] = 'client'
default['consul']['servers'] = []
default['consul']['extra_params']['server'] = false

default['consul_template']['version'] = "0.10.0"
default['consul_template']['checksums']['consul-template_0.10.0_linux_amd64'] = 'ef298a2ae54cf51dbfc4108194299a9055b252ff9b917e7dd40c72fa30820096'

