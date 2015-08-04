name        'mapr_consul_hive'
description 'MapR Hive'

run_list *%w[
  role[mapr_consul]
]
