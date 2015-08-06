name        'mapr_cluster_historyserver'
description 'MapR YARN History Server'

run_list *%w[
  role[mapr_cluster]
]
