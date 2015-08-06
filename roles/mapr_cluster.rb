name        'mapr_cluster'
description 'MapR default role'

run_list *%w[
  recipe[mapr-cluster::default]
]
