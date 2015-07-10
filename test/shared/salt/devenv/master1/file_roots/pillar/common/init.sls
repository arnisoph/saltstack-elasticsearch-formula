salt:
  lookup:
    master:
      pkgs:
        - python-git
        - python-apt
        - python-mysqldb
        - lsb-release
      config:
        master:
          config:
            #ext_job_cache: elasticsearcharbe
            autosign_file: /etc/salt/autosign.conf
            pillar_opts: false
            pillar_source_merging_strategy: recurse
            state_verbose: false
            yaml_utf8: true
            log_level: debug

            file_roots:
              base:
                - /srv/salt/states
                - /srv/salt/contrib/states

            pillar_roots:
              base:
                - /srv/salt/pillar/share
                - /srv/salt/pillar/examples

            #module_dirs:
            #  - /srv/salt/_modules/common
            #  - /srv/salt/_modules/formulas

            #runner_dirs:
            #- /home/arbe/runners
            #- /usr/local/share/salt-runners
    minion:
      config:
        minion:
          config:
            log_level: debug
            master: 10.10.10.100
            module_dirs:
              - /srv/salt/_modules/common
              - /srv/salt/_modules/formulas
            states_dirs:
              - /srv/salt/_states/common
      pkgs:
{% if salt['grains.get']('os') == 'Debian' %}
        - python-apt
        - python-git
        - python-psutil
        - lsb-release
        - dnsutils
        - python-zmq {%- if salt['grains.get']('oscodename') == 'wheezy' %}: '13.1.0-1~bpo70+1'{% endif %}
        - python-requests {%- if salt['grains.get']('oscodename') == 'wheezy' %}: '2.0.0-1~bpo70+2'{% endif %}
{% endif %}

elasticsearch:
  host: '10.10.10.100:9200'
  number_of_shards: 1
  number_of_replicas: 0

bash:
  config:
    manage:
      users:
        - root
