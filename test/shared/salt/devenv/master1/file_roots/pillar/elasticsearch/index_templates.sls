elasticsearch:
  lookup:
    index_templates:
      salt_defaults:
        #ensure: absent
        config:
          template: salt-*
          order: 10
          settings:
            number_of_shards: 1
          mappings:
            2014_7_a:
              #_all:
              #  enabled: False
              properties:
                '@timestamp':
                  type: date
                  format: date_time
                success:
                  type: boolean
                retcode:
                  type: short
                minion:
                  type: string
                  index: not_analyzed
                fun:
                  type: string
                  index: not_analyzed
                jid:
                  type: string
                  index: not_analyzed
      salt-test_ping:
        #ensure: absent
        config:
          template: salt-test_ping-*
          order: 100
          #mappings:
          #  2014_7_a:
          #    properties:
          #      data:
          #        type: boolean
      salt-disk_usage:
        #ensure: absent
        config:
          template: salt-disk_usage-*
          order: 100
          #mappings:
          #  2014_7_a:
          #    properties:
          #      data:

#      salt-status_loadavg:
#        #ensure: absent
#        config:
#          template: salt-status_loadavg-*
#          order: 100
#          mappings:
#            2014_7_a:
#              properties:
#                data:
#                  type: object
#                  include_in_all: True
#                  path: full
#                  dynamic: strict
#                  properties:
#                    1-min:
#                      type: float
#                    5-min:
#                      type: float
#                    15-min:
#                      type: float


      montoring_defaults:
        config:
          template: monitoring-*
          order: 10
          settings:
            number_of_shards: 5
          mappings:
            common:
              #_all:
              #  enabled: False
              properties:
                '@timestamp':
                  type: date
                  format: date_time
                code:
                  type: short
                entity:
                  type: string
                  index: not_analyzed
                fun:
                  type: string
                  index: not_analyzed
                origin:
                  type: string
                  index: not_analyzed
      #monitoring-sysloadavg:
      #  config:
      #    template: monitoring-sysloadavg-*
      #    order: 100
      #    mappings:
      #      common: #TOOD => 1
      #        properties:
      #          metrics:
      #            properties:
      #              1-min:
      #                type: float
      #              5-min:
      #                type: float
      #              15-min:
      #                type: float

