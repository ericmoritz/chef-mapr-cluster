package "mapr-zookeeper"

service 'mapr-zookeeper' do
  action [:enable, :start]
end

