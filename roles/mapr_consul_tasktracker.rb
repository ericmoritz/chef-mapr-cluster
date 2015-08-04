name        'mapr_consul_tasktracker'
description 'MapR tasktracker'

run_list *%w[
  role[mapr_consul]
]
