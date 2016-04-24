# -*- coding: utf-8 -*-
# vim: ft=sls

#FIXME
{# from "rabbitmq/map.jinja" import rabbitmq with context #}

{% set rabbitmq = salt['pillar.get']('rabbitmq:lookup:pcs', {}) %}

{% if rabbitmq.rabbitmq_cib is defined and rabbitmq.rabbitmq_cib %}
rabbitmq_pcs__cib_created_{{rabbitmq.rabbitmq_cib}}:
  pcs.cib_created:
    - cibname: {{rabbitmq.rabbitmq_cib}}
{% endif %}

{% if 'resources' in rabbitmq %}
{% for resource, resource_data in rabbitmq.resources.items()|sort %}
rabbitmq_pcs__resource_created_{{resource}}:
  pcs.resource_created:
    - resource_id: {{resource}}
    - resource_type: "{{resource_data.resource_type}}"
    - resource_options: {{resource_data.resource_options|json}}
{% if rabbitmq.rabbitmq_cib is defined and rabbitmq.rabbitmq_cib %}
    - require:
      - pcs: rabbitmq_pcs__cib_created_{{rabbitmq.rabbitmq_cib}}
    - require_in:
      - pcs: rabbitmq_pcs__cib_pushed_{{rabbitmq.rabbitmq_cib}}
    - cibname: {{rabbitmq.rabbitmq_cib}}
{% endif %}
{% endfor %}
{% endif %}

{% if 'constraints' in rabbitmq %}
{% for constraint, constraint_data in rabbitmq.constraints.items()|sort %}
rabbitmq_pcs__constraint_created_{{constraint}}:
  pcs.constraint_created:
    - constraint_id: {{constraint}}
    - constraint_type: "{{constraint_data.constraint_type}}"
    - constraint_options: {{constraint_data.constraint_options|json}}
{% if rabbitmq.rabbitmq_cib is defined and rabbitmq.rabbitmq_cib %}
    - require:
      - pcs: rabbitmq_pcs__cib_created_{{rabbitmq.rabbitmq_cib}}
    - require_in:
      - pcs: rabbitmq_pcs__cib_pushed_{{rabbitmq.rabbitmq_cib}}
    - cibname: {{rabbitmq.rabbitmq_cib}}
{% endif %}
{% endfor %}
{% endif %}

{% if rabbitmq.rabbitmq_cib is defined and rabbitmq.rabbitmq_cib %}
rabbitmq_pcs__cib_pushed_{{rabbitmq.rabbitmq_cib}}:
  pcs.cib_pushed:
    - cibname: {{rabbitmq.rabbitmq_cib}}
{% endif %}
