name        'mapr_consul_resourcemanager'
description 'MapR YARN Resource Manager'

run_list *%w[
  role[mapr_consul]
]
