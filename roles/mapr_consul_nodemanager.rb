name        'mapr_consul_nodemanager'
description 'MapR YARN Node Manager'

run_list *%w[
  role[mapr_consul]
]
