{% from "elk/map.jinja" import elk with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elk.elasticsearch_pkg }}
    - refresh: True
    - failhard: True

elasticsearch_service:
  service.running:
    - name: {{ elk.elasticsearch_srv }}
    - enable: True
    - require:
      - pkg: {{ elk.elasticsearch_pkg }}


elasticsearch_config:
  file.managed:
    - name: {{ elk.elasticsearch_config }}
    - source: {{ elk.elasticsearch_config_src }}
    - template: jinja
    - watch_in:
      - service: {{ elk.elasticsearch_srv }}
    - require:
      - pkg: {{ elk.elasticsearch_pkg }}
