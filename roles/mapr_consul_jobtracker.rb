name        'mapr_consul_jobtracker'
description 'MapR jobtracker'

run_list *%w[
  role[mapr_consul]
]
