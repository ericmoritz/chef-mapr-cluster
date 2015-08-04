name        'mapr_consul_nfs'
description 'MapR nfs'

run_list *%w[
  role[mapr_consul]
]
