{% from "elk/map.jinja" import elk with context %}

kibana_pkg:
  pkg.installed:
    - name: {{ elk.kibana_pkg  }}
    - refresh: True
    - failhard: True

kibana_service:
  service.running:
    - name: {{ elk.kibana_srv }}
    - enable: True
    - require:
      - pkg: {{ elk.kibana_pkg  }}

kibana_log:
  file.managed:
    - name: /var/log/kibana/kibana.log
    - user: kibana
    - group: kibana
    - mode: 644
    - makedirs: true

kibana_config:
  file.managed:
    - name: {{ elk.kibana_config }}
    - source: {{ elk.kibana_config_src }}
    - template: jinja
    - watch_in:
      - service: {{ elk.kibana_srv }}
    - require:
      - pkg: {{ elk.kibana_pkg }}
