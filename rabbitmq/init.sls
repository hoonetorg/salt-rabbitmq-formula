# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rabbitmq/map.jinja" import rabbitmq with context %}

include:
  - rabbitmq.install
  - rabbitmq.config
  - rabbitmq.service

extend:
  rabbitmq_config__conffile:
    file:
      - require:
        - pkg: rabbitmq_install__pkg
  rabbitmq_config__confenvfile:
    file:
      - require:
        - pkg: rabbitmq_install__pkg
  rabbitmq_service__service:
    service:
      - require:
        - pkg: rabbitmq_install__pkg
{% if rabbitmq.service.state in [ 'running', 'dead' ] %}
      - watch:
{% endif %}
        - file: rabbitmq_config__conffile
        - file: rabbitmq_config__confenvfile
{% if rabbitmq.erlang_cookie is defined and rabbitmq.erlang_cookie %}
        - file: rabbitmq_config__erlang_cookie_file
{% endif %}

