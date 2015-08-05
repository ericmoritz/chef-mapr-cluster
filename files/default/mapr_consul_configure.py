#!/usr/bin/env python
import sys
import json
import subprocess

def format_arg(flag, items):
    items = filter(None, items)
    if items:
        return [flag, ",".join(items)]
    else:
        return []
                
data = json.load(open(sys.argv[1]))
services = data['services']

cmd = (
    [
        "/opt/mapr/server/configure.sh",
        "-u", "mapr",
        "-g", "mapr",
        "-N", data['clustername']
    ]
    + format_arg(
        "-Z", services.get('mapr-zookeeper', [])
    )
    + format_arg(
        "-C", services.get('mapr-cldb', [])
    )
    + format_arg(
        "-RM", services.get('mapr-resourcemanager', [])
    )
)

print cmd
