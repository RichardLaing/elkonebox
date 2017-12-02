{% from "elk/map.jinja" import elk with context %}

openjdk_install:
  pkg.installed:
    - name: openjdk-8-jre
    - refresh: True
    - failhard: True

elstatic_repo:
  pkgrepo.managed:
    - humanname: Elastic Search Repo
    - name: deb https://artifacts.elastic.co/packages/5.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elk.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

nginx_install:
  pkg.installed:
    - name: nginx

nginx_config:
  file.managed:
    - name: /etc/nginx/sites-enabled/default
    - source: salt://elk/files/nginx/default.jinja
    - template: jinja

ngix_restart:
  cmd.run:
    - name: service nginx restart
