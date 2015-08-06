name        'mapr_cluster_hbase_regionserver'
description 'MapR HBase Regionserver'

run_list *%w[
  role[mapr_cluster]
]
