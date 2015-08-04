consul_config '/etc/consul.json' do
  user 'root'
  group 'root'
  server false
  start_join node['mapr_consul']['consul_servers']
end

consul_service 'consul' do
  user 'root'
  group 'root'
  install_method 'binary'
  binary_url node['consul']['binary_url']
end

