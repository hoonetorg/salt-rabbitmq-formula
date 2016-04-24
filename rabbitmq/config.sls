# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rabbitmq/map.jinja" import rabbitmq with context %}

rabbitmq_config__conffile:
  file.managed:
    - name: {{ rabbitmq.conffile }}
    - source: salt://rabbitmq/files/rabbitmq.config.jinja
    - template: jinja
    - context:
      confdict: {{rabbitmq|json}}
    - mode: 644
    - user: root
    - group: root

rabbitmq_config__confenvfile:
  file.managed:
    - name: {{ rabbitmq.confenvfile }}
    - source: salt://rabbitmq/files/rabbitmq-env.conf.jinja
    - template: jinja
    - context:
      confdict: {{rabbitmq|json}}
    - mode: 644
    - user: root
    - group: root

{% if rabbitmq.erlang_cookie is defined and rabbitmq.erlang_cookie %}
rabbitmq_config__erlang_cookie_file:
  file.managed:
    - name: {{ rabbitmq.erlang_cookie_file }}
    - mode: "0400"
    - user: {{ rabbitmq.user }}
    - group: {{ rabbitmq.group }}
    - contents_pillar: rabbitmq:lookup:erlang_cookie
    - contents_newline: False
{% endif %}
