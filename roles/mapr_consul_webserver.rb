name        'mapr_consul_webserver'
description 'MapR webserver'

run_list *%w[
  role[mapr_consul]
]
