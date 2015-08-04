name        'mapr_consul_mysql_server'
description 'A role for running Mysql service'

run_list *%w[
  mapr_consul::mysql_server
]
