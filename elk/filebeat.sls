{% from "elk/map.jinja" import elk with context %}

filebeat_pkg:
  pkg.installed:
    - name: {{ elk.filebeat_pkg }}
    - refresh: True
    - failhard: True


filebeat_service:
  service.running:
    - name: {{ elk.filebeat_srv }}
    - enable: True
    - require:
      - pkg: {{ elk.filebeat_pkg }}

filebeat_config:
  file.managed:
    - name: {{ elk.filebeat_config }}
    - source: {{ elk.filebeat_config_src }}
    - template: jinja
    - watch_in:
      - service: {{ elk.filebeat_srv }}
    - require:
      - pkg: {{ elk.filebeat_pkg }}
