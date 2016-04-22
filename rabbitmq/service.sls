# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rabbitmq/map.jinja" import rabbitmq with context %}

rabbitmq_service__service:
  service.{{ rabbitmq.service.state }}:
    - name: {{ rabbitmq.service.name }}
{% if rabbitmq.service.state in [ 'running', 'dead' ] %}
    - enable: {{ rabbitmq.service.enable }}
{% endif %}

