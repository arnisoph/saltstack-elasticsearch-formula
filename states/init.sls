#!jinja|yaml

{% set datamap = salt['formhelper.get_defaults']('elasticsearch', saltenv, ['yaml'])['yaml'] %}

include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

elasticsearch:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs|default({}) }}
  service:
    - {{ datamap.service.ensure|default('running') }}
    - name: {{ datamap.service.name|default('elasticsearch') }}
    - enable: {{ datamap.service.enable|default(True) }}

{% if 'defaults_file' in datamap.config.manage|default([]) %}
  {% set f = datamap.config.defaults_file %}
elasticsearch_defaults_file:
  file:
    - managed
    - name: {{ f.path }}
    - source: {{ f.template_path|default('salt://elasticsearch/files/defaults_file.' ~ salt['grains.get']('oscodename')) }}
    - mode: {{ f.mode|default(644) }}
    - user: {{ f.user|default('root') }}
    - group: {{ f.group|default('root') }}
    - template: jinja
    - context:
      datamap: {{ datamap }}
    - watch_in:
      - service: elasticsearch
{% endif %}

{% if 'main' in datamap.config.manage|default([]) %}
  {% set f = datamap.config.main %}
elasticsearch_config_main:
  file:
    - managed
    - name: {{ f.path|default('/etc/elasticsearch/elasticsearch.yml') }}
    - source: {{ f.template_path|default('salt://elasticsearch/files/main') }}
    - mode: {{ f.mode|default(644) }}
    - user: {{ f.user|default('root') }}
    - group: {{ f.group|default('root') }}
    - template: jinja
    - context:
      datamap: {{ datamap }}
    - watch_in:
      - service: elasticsearch
{% endif %}

{% if 'logging' in datamap.config.manage|default([]) %}
  {% set f = datamap.config.logging %}
elasticsearch_config_logging:
  file:
    - managed
    - name: {{ f.path|default('/etc/elasticsearch/logging.yml') }}
    - source: {{ f.template_path|default('salt://elasticsearch/files/logging') }}
    - mode: {{ f.mode|default(644) }}
    - user: {{ f.user|default('root') }}
    - group: {{ f.group|default('root') }}
    - template: jinja
    - context:
      datamap: {{ datamap }}
    - watch_in:
      - service: elasticsearch
{% endif %}

{% for p in datamap.plugins|default([]) %}
  {% set java_home = datamap.defaults.JAVA_HOME|default(false) %}
  {% if 'url' in p %}
    {% set url = '--url \'' ~ p.url ~ '\'' %}
  {% else %}
    {% set url = '' %}
  {% endif %}

elasticsearch_install_plugin_{{ p.name }}:
  cmd:
    - run
    - name: {% if java_home %}export JAVA_HOME='{{ java_home }}' && {% endif %}{{ datamap.basepath|default('/usr/share/elasticsearch') }}/bin/plugin -v -t 30s {{ url }} install '{{ p.name }}'
    - unless: test -d '{{ datamap.basepath|default('/usr/share/elasticsearch') }}/plugins/{{ p.installed_name }}'
{% endfor %}
