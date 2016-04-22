# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "rabbitmq/map.jinja" import rabbitmq with context %}

rabbitmq_install__pkg:
  pkg.installed:
    - pkgs: {{ rabbitmq.pkgs }}
