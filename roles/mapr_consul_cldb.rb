name        'mapr_consul_cldb'
description 'MapR cldb'

run_list *%w[
  role[mapr_consul]
]
