name        'mapr_consul_client'
description 'MapR client'

run_list *%w[
  role[mapr_consul]
]
