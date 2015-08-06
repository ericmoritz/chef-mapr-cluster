name        'mapr_cluster_client'
description 'MapR client'

run_list *%w[
  role[mapr_cluster]
]
