name        'mapr_consul_metrics'
description 'MapR metrics'

run_list *%w[
  role[mapr_consul]
]
