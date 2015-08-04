name        'mapr_consul_historyserver'
description 'MapR YARN History Server'

run_list *%w[
  role[mapr_consul]
]
