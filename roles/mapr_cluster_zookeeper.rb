name        'mapr_cluster_zookeeper'
description 'MapR zookeeper'

run_list *%w[
  role[mapr_cluster]
]
