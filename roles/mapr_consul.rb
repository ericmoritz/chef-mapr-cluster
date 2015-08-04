name        'mapr_consul'
description 'MapR default role'

run_list *%w[
  recipe[mapr_consul::default]
]
