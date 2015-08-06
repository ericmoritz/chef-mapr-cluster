name        'mapr_cluster_hive'
description 'MapR Hive'

run_list *%w[
  role[mapr_cluster]
]
