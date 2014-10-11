#!jinja|yaml

{% from 'elasticsearch/defaults.yaml' import rawmap_osfam with context %}
{% from 'elasticsearch/defaults.yaml' import rawmap_os with context %}
{% set datamap = salt['grains.filter_by'](rawmap_osfam, merge=salt['grains.filter_by'](rawmap_os|default({}), grain='os', merge=salt['pillar.get']('elasticsearch:lookup'))) %}

include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

{% if datamap.repo.manage|default(True) %}
  {% if salt['grains.get']('os_family') == 'Debian' %}
elasticsearch_repo:
  pkgrepo:
    - managed
    - name: {{ datamap.repo.debtype|default('deb') }} {{ datamap.repo.url }} {{ datamap.repo.dist }} {{ datamap.repo.comps }}
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - key_url: {{ datamap.repo.keyurl }}
  {% endif %}
{% endif %}

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
defaults_file:
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
main:
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
logging:
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
  {% set java_home = salt['pillar.get']('elasticsearch:lookup:defaults:JAVA_HOME', false) %}

install_plugin_{{ p.name }}:
  cmd:
    - run
    - name: {% if java_home %}export JAVA_HOME='{{ java_home }}' && {% endif %}{{ datamap.basepath|default('/usr/share/elasticsearch') }}/bin/plugin -v -t 10s --url '{{ p.url }}' --install '{{ p.name }}'
    - unless: test -d '{{ datamap.basepath|default('/usr/share/elasticsearch') }}/plugins/{{ p.installed_name }}'
{% endfor %}
