name        'mapr_consul_hbase_master'
description 'MapR HBase Master'

run_list *%w[
  role[mapr_consul]
]
