#!jinja|yaml

{% from 'elasticsearch/defaults.yaml' import rawmap_osfam with context %}
{% from 'elasticsearch/defaults.yaml' import rawmap_os with context %}
{% set datamap = salt['grains.filter_by'](rawmap_osfam, merge=salt['grains.filter_by'](rawmap_os, grain='os', merge=salt['pillar.get']('elasticsearch:lookup'))) %}

include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}
