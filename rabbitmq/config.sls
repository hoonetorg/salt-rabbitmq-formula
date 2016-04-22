# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rabbitmq/map.jinja" import rabbitmq with context %}

rabbitmq_config__conffile:
  file.managed:
    - name: {{ rabbitmq.conffile }}
    - source: salt://rabbitmq/files/configtempl.jinja
    - rabbitmq: jinja
    - context:
      confdict: {{rabbitmq|json}}
    - mode: 644
    - user: root
    - group: root
