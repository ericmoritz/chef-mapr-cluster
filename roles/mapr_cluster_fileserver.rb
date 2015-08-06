name        'mapr_cluster_fileserver'
description 'MapR fileserver'

run_list *%w[
  role[mapr_cluster]
]
