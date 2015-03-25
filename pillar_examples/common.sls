{# https://github.com/bechtoldt/saltstack-repos-formula #}
repos:
  lookup:
    repos:
      elasticsearch:
        url: http://packages.elasticsearch.org/elasticsearch/1.5/debian
        dist: stable
        comps:
          - main
        keyurl: http://packages.elasticsearch.org/GPG-KEY-elasticsearch

elasticsearch:
  lookup:
    defaults:
      JAVA_HOME: /opt/java/jdk/current/src
      ES_HEAP_SIZE: {{ (salt['grains.get']('mem_total')/2)|round|int }}m
    settings:
      cluster:
        name: myindex
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
        #url: 'https://gitlab.domain.de/github/elasticsearch-kopf/repository/archive.zip?ref=master'
      - name: karmi/elasticsearch-paramedic
        installed_name: paramedic

{# https://github.com/bechtoldt/saltstack-java-formula #}
java:
  lookup:
    manage:
      jdk:
        current_ver: 8u20
        versions:
          8u20:
            source: file:///vagrant/share/misc/jdk-8u20-linux-x64.tar.gz
            source_hash: md5=ec7f89dc3697b402e2c851d0488f6299
            version: jdk1.8.0_20

{# https://github.com/bechtoldt/saltstack-sysctl-formula #}
# See http://www.elasticsearch.org/guide/en/elasticsearch/reference/1.x/setup-configuration.html#setup-configuration
sysctl:
  lookup:
    params:
      - name: vm.swappiness
        value: 0
      - name: vm.max_map_count
        value: 262144
