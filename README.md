# salt-db-docker
Creates docker databases instances with SaltStack using dockerng module

## Configuration:
It leverages the saltstack new dockerng module.

How this is currently configured until docker-ng is out in the official saltstack 2015.8 release:
```bash
apt-get install zmq-lib3 python-apt python-pip
pip install virtualenv
mkdir ~/.virtualenvs
pip --site-packages ~/.virtualenvs/salt
source ~/.virtualenvs/salt/bin/activate
pip install docker-py GitPython
cd /opt
git clone https://github.com/saltstack/salt.git
cd /opt/salt
git checkout -b 2015.8 origin/2015.8
pip install -e .
```

Sample `/etc/salt/minion` config would be:
```
file_client: local

fileserver_backend:
  - git

gitfs_remotes:
  - https://github.com/robertjameshernandez/salt-db-docker.git
```
*Note:* The above assumes you want to use these states using `GitFS`

Copy the same pillar into your actual pillar and test:
```bash
source ~/.virtualenvs/salt/bin/activate
salt-call --local state.highstate test=true
```

If everything looks good, time to run actual highstate:
```bash
salt-call --local state.highstate
```

### Issues:
Docker should be `running` since it currently causes errors in `__virtual__` when triyng to run something like:
```bash
salt-call --local sys.state_doc "dockerng"
```

## Cleanup Database:
There is a state for cleaning up states as well. It involves passing in special pillar data to teardown and clean docker instances:
```bash
source ~/.virtualenvs/salt/bin/activate
salt-call --local state.sls cleanup pillar='{"cleanup_docker": ["mysql1", "postgres1"]}'
```
*Note:* This would remove `mysql1 and postgres1` and any binding directories or files
