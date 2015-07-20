python-apt:
  pkg.installed

install_docker_ppa:
  pkgrepo.managed:
    - humanname: Docker PPA
    - name: deb https://get.docker.io/ubuntu docker main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 36A1D7869245C8950F966E92D8576A8BA88D21E9
    - keyserver: keyserver.ubuntu.com
    - require:
      - pkg: python-apt
    - require_in:
      - pkg: lxc-docker

  pkg.installed:
    - name: lxc-docker
    - refresh: True
