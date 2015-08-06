name        'mapr_cluster_resourcemanager'
description 'MapR YARN Resource Manager'

run_list *%w[
  role[mapr_cluster]
]
