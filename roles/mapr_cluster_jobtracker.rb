name        'mapr_cluster_jobtracker'
description 'MapR jobtracker'

run_list *%w[
  role[mapr_cluster]
]
