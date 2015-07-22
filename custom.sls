custom_pkgs:
  pkg.installed:
    - pkgs:
      - tmux
      - vim
      - git
      - mysql-client-5.5

/root/.virtualenvs/salt/bin/salt-call --local state.highstate:
  cron.present:
    - identifier: SALTHIGHSTATE
    - user: root
    - minute: '*/30'
