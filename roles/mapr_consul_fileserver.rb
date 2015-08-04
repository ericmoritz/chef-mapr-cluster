name        'mapr_consul_fileserver'
description 'MapR fileserver'

run_list *%w[
  role[mapr_consul]
]
