{% from "docker/map.jinja" import docker_config with context %}

python-apt:
  pkg.installed

docker-py:
  pip.installed:
    - bin_env: /root/.virtualenvs/salt

install_docker_ppa:
  pkgrepo.managed:
    - humanname: Docker PPA
    - name: deb https://get.docker.io/ubuntu docker main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 36A1D7869245C8950F966E92D8576A8BA88D21E9
    - keyserver: keyserver.ubuntu.com
    - require:
      - pkg: python-apt
      - pip: docker-py
    - require_in:
      - pkg: lxc-docker

  pkg.installed:
    - name: lxc-docker
    - refresh: True

  file.managed:
    - name: /etc/default/docker
    - source: salt://docker/default
    - template: jinja
    - context:
        options: {{ docker_config.opts }}
    - require:
      - pkg: lxc-docker

  service.running:
    - name: docker
    - enable: True
    - watch:
      - file: /etc/default/docker
