name        'mapr_cluster_tasktracker'
description 'MapR tasktracker'

run_list *%w[
  role[mapr_cluster]
]
