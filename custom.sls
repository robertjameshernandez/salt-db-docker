custom_pkgs:
  pkg.installed:
    - pkgs:
      - tmux
      - vim
      - git

salt-call --local state.highstate:
  cron.present:
    - identifier: SALTHIGHSTATE
    - user: root
    - minute: '*/30'
