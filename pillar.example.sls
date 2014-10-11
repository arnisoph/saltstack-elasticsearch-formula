elasticsearch:
  lookup:
    repo:
      keyurl: salt://elasticsearch/files/GPG-KEY-elasticsearch
    defaults:
      JAVA_HOME: /opt/java/jdk/current/src
      ES_HEAP_SIZE: {{ (salt['grains.get']('mem_total')/2)|round|int }}m
    settings:
      cluster:
        name: elasticsearch-la
      node:
        name: {{ salt['grains.get']('fqdn') }}
        master: true
        data: true
      index:
        number_of_replicas: 0
      network:
        host: {{ salt['grains.get']('ip_interfaces:eth1', ['127.0.0.1'])[0] }}
      gateway:
        expected_nodes: 1
      discovery:
        zen:
          ping:
            multicast:
              enabled: false
    plugins:
      - name: elasticsearch-kopf
        installed_name: kopf
        url: 'https://gitlab.domain.de/github/elasticsearch-kopf/repository/archive.zip?ref=master'
      - name: elasticsearch-paramedic
        installed_name: paramedic
        url: 'https://gitlab.domain.de/github/elasticsearch-paramedic/repository/archive.zip?ref=master'

java:
  jdk:
    current_ver: 8u20
    versions:
      8u20:
        source: http://fileserver.domain.de/share/java/jdk-8u20-linux-x64.tar.gz
        source_hash: md5=ec7f89dc3697b402e2c851d0488f6299
        version: jdk1.8.0_20

# See http://www.elasticsearch.org/guide/en/elasticsearch/reference/1.x/setup-configuration.html#setup-configuration
sysctl:
  params:
    - name: vm.swappiness
      value: 0
    - name: vm.max_map_count
      value: 262144
