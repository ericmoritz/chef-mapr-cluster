name        'mapr_cluster_nfs'
description 'MapR nfs'

run_list *%w[
  role[mapr_cluster]
]
