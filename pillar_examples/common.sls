elasticsearch:
  lookup:
    defaults:
      JAVA_HOME: /opt/java/jdk/current/src
      ES_HEAP_SIZE: {{ (salt['grains.get']('mem_total')/2)|round|int }}m
    settings:
      cluster:
        name: ubersearch
      node:
        name: {{ salt['grains.get']('fqdn') }}
        master: true
        data: true
      index:
        number_of_replicas: 0
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
        url: 'https://github.com/lmenezes/elasticsearch-kopf/archive/master.zip'
        #url: 'https://gitlab.domain.de/github/elasticsearch-kopf/repository/archive.zip?ref=master'
      - name: karmi/elasticsearch-paramedic
        installed_name: paramedic
#    indices:
#      testindex:
#        body:
#          settings:
#            index:
#              number_of_replicas: 0
#      testindex2:
#        ensure: absent
#    index_templates:
#      salt-test_ping:
#        ensure: present
#        config:
#          template: salt-test_ping-*
#          settings:
#            number_of_shards: 1
#          mappings:
#            2014_7_a:
#              _all:
#                enabled: False
#              properties:
#                '@timestamp':
#                  type: date
#                result:
#                  type: boolean
#                minion:
#                  type: string
#                  index: not_analyzed
#                fun:
#                  type: string
#                  index: not_analyzed
#                jid:
#                  type: string
#                  index: not_analyzed
#                return:
#                  type: boolean
#          aliases:
#            salt-test_ping: {}

repos: # Extra-Formula: https://github.com/bechtoldt/saltstack-repos-formula
  lookup:
    repos:
      elasticsearch:
{% if salt['grains.get']('os_family') == 'Debian' %}
        url: http://packages.elasticsearch.org/elasticsearch/1.5/debian
        dist: stable
        comps:
          - main
{% elif salt['grains.get']('os_family') == 'RedHat' %}
        url: http://packages.elastic.co/elasticsearch/1.5/centos
{% endif %}
        keyurl: http://packages.elasticsearch.org/GPG-KEY-elasticsearch


java: # Extra-Formula: https://github.com/bechtoldt/saltstack-java-formula
  lookup:
    manage:
      jdk:
        current_ver: 8u66
        versions:
          8u66:
            source: file:///tmp/jdk-8u66-linux-x64.tar.gz
            source_hash: md5=196880a42c45ec9ab2f00868d69619c0
            version: jdk1.8.0_66

# See http://www.elasticsearch.org/guide/en/elasticsearch/reference/1.x/setup-configuration.html#setup-configuration
sysctl: # Extra-Formula: https://github.com/bechtoldt/saltstack-sysctl-formula
  lookup:
    params:
      - name: vm.swappiness
        value: 1
      - name: vm.max_map_count
        value: 262144


#TODO pip install elasticsearch
