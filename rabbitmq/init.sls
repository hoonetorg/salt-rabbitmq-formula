# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - rabbitmq.install
  - rabbitmq.config
  - rabbitmq.service

extend:
  rabbitmq_config__conffile:
    file:
      - require:
        - pkg: rabbitmq_install__pkg
  rabbitmq_service__service:
    service:
      - watch:
        - file: rabbitmq_config__conffile
      - require:
        - pkg: rabbitmq_install__pkg

