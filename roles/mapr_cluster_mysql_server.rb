name        'mapr_cluster_mysql_server'
description 'A role for running Mysql service'

run_list *%w[
  mapr_cluster::mysql_server
]
