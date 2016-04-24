#!jinja|yaml
{% set node_ids = salt['pillar.get']('rabbitmq:lookup:pcs:node_ids') -%}
{% set admin_node_id = salt['pillar.get']('rabbitmq:lookup:pcs:admin_node_id') -%}

# node_ids: {{node_ids|json}}
# admin_node_id: {{admin_node_id}}

rabbitmq_orchestration__install:
  salt.state:
    - tgt: {{node_ids|json}}
    - tgt_type: list
    - expect_minions: True
    - sls: rabbitmq

rabbitmq_orchestration__pcs:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - sls: rabbitmq.pcs
    - require:
      - salt: rabbitmq_orchestration__install
