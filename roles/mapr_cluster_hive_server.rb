name        'mapr_cluster_hive_server'
description 'MapR Hive Server'

run_list *%w[
  role[mapr_cluster]
]
