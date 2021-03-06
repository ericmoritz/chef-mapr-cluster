default['mapr_cluster']['packages'] = {
  "mapr_cluster_zookeeper" => {
    "role" => "mapr_cluster_zookeeper",
    "pkg_name" => "mapr-zookeeper",
    "services" => [
      {"name"=> "mapr-zookeeper", "port" => 5181, "tags" => ["core"]}
    ]
  },
  "mapr_cluster_cldb" => {
    "role" => "mapr_cluster_cldb",
    "pkg_name" => "mapr-cldb",
    "services" => [
      {"name" => "mapr-cldb", "port" => 7222},
      {"name" => "mapr-cldb-http", "port" => 7220, "tags" => ["http"]},
      {"name" => "mapr-cldb-jmx", "port" => 7220}
    ]
  },
  "mapr_cluster_fileserver" => {
    "role" => "mapr_cluster_fileserver",
    "pkg_name" => "mapr-fileserver",
    "services" => [
      {"name" => "mapr-fileserver"}
    ]
  },
  "mapr_cluster_nfs" => {
    "role" => "mapr_cluster_nfs",
    "pkg_name" => "nfs",
    "recipe" => "nfs",
    "services" => [
      {"name" => "mapr-nfs", "port" => 2049},
      {"name" => "mapr-nfs-monitor", "port" => 9997},
      {"name" => "mapr-nfs-management", "port" => 9998}
    ]
  },
  "mapr_cluster_resourcemanager" => {
    "role" => "mapr_cluster_resourcemanager",
    "pkg_name" => "mapr-resourcemanager",
    "services" => [
      {"name" => "mapr-resourcemanager-admin-rpc", "port" => 8033},
      {"name" => "mapr-resourcemanager-client-rpc", "port" => 8032},
      {"name" => "mapr-resourcemanager-http", "port" => 8088, "tags" => ["http"]},
      {"name" => "mapr-resourcemanager-https", "port" => 8090, "tags" => ["https"]}
    ]
  },
  "mapr_cluster_nodemanager" => {
    "role" => "mapr_cluster_nodemanager",
    "pkg_name" => "mapr-nodemanager",
    "services" => [
      {"name" => "mapr-nodemanager", "port" => 8041},
      {"name" => "mapr-nodemanager-http", "port" => 8042, "tags" => ["http"]},
      {"name" => "mapr-nodemanager-https", "port" => 8044, "tags" => ["https"]}
    ]
  },
  "mapr_cluster_historyserver" => {
    "role" => "mapr_cluster_historyserver",
    "pkg_name" => "mapr-historyserver",
    "services" => [
      {"name" => "mapr-historyserver", "port" => 10020, "tags" => ["rpc"]},
      {"name" => "mapr-historyserver-http", "port" => 19888, "tags" => ["http"]},
      {"name" => "mapr-historyserver-https", "port" => 19890, "tags" => ["https"]}
    ]
  },
  "mapr_cluster_webserver" => {
    "role" => "mapr_cluster_webserver",
    "pkg_name" => "mapr-webserver",
    "services" => [
      {"name" => "mapr-webserver-http", "port" => 8080, "tags" => ["http"]},
      {"name" => "mapr-webserver-https", "port" => 8443, "tags" => ["https"]},
    ]    
  }
}
