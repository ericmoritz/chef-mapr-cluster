name        'mapr_cluster_cldb'
description 'MapR cldb'

run_list *%w[
  role[mapr_cluster]
]
