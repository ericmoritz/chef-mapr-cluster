name        'mapr_consul_zookeeper'
description 'MapR zookeeper'

run_list *%w[
  role[mapr_consul]
]
