unattended-upgrades:
  pkg.installed

/etc/apt/apt.conf.d/20auto-updates:
  file.managed:
    - source: salt://apt/20auto-upgrades
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: unattended-upgrades
