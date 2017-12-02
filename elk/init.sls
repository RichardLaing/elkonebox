{% from "elk/map.jinja" import elk with context %}

include:
  - .common
  - .filebeat
  - .logstash
  - .elasticsearch
  - .kibana
