name        'mapr_cluster_pig'
description 'MapR Pig'

run_list *%w[
  role[mapr_cluster]
]
