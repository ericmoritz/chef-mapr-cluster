name        'mapr_cluster_metrics'
description 'MapR metrics'

run_list *%w[
  role[mapr_cluster]
]
