name        'mapr_consul_pig'
description 'MapR Pig'

run_list *%w[
  role[mapr_consul]
]
