name        'mapr_consul_hbase_regionserver'
description 'MapR HBase Regionserver'

run_list *%w[
  role[mapr_consul]
]
