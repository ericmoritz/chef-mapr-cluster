name        'mapr_cluster_webserver'
description 'MapR webserver'

run_list *%w[
  role[mapr_cluster]
]
