{% from "docker/mysql-docker/map.jinja" import mysql_docker with context %}
{% from "docker/postgres-docker/map.jinja" import postgres_docker with context %}

{% set docker_list = {} %}
{% do docker_list.update(mysql_docker.instances) %}
{% do docker_list.update(postgres_docker.instances) %}

{% for instance, attr in docker_list.iteritems() -%}
{# Check if instance exists in clean_docker pillar list.
   If this is not set it will just assume that instance
   should be removed #}
{% if instance in salt['pillar.get']('cleanup_docker', default=instance) %}
{{ instance }}:
  dockerng.absent:
    - name: {{ instance }}
    - force: True

{% if attr['binds'] is defined %}
{% for bind in attr['binds'] %}
{{ bind.split(':')[0] }}:
  file.absent:
    - require: 
      - dockerng: {{ instance }}
{% endfor %}
{% endif %}
{% endif %}

{% endfor %}

