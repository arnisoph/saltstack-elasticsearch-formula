#!jinja|yaml

{% from 'elasticsearch/defaults.yaml' import rawmap_osfam with context %}
{% set datamap = salt['grains.filter_by'](rawmap_osfam, grain='os_family', merge=salt['pillar.get']('elasticsearch:lookup')) %}

test file with data:
  file.managed:
    - name: /tmp/test.txt
    - source: salt://elasticsearch/files/test.jinja
    - context:
        datamap: {{ datamap }}
