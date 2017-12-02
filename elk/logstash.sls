{% from "elk/map.jinja" import elk with context %}

logstash_pkg:
  pkg.installed:
    - name: {{ elk.logstash_pkg  }}
    - refresh: True
  service.running:
    - name: {{ elk.logstash_srv }}
    - enable: True
    - require:
      - pkg: {{ elk.logstash_pkg }}


logstash_config:
  file.managed:
    - name: {{ elk.logstash_config }}
    - source: {{ elk.logstash_config_src }}
    - template: jinja
    - watch_in:
      - service: {{ elk.logstash_srv }}
    - require:
      - pkg: {{ elk.logstash_pkg }}


/etc/logstash/conf.d/:
  file.recurse:
    - source: salt://elk/files/logstash/conf.d/
    - maxdepth: 1
