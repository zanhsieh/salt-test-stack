# salt-test-stack
Easy Salt state testing with Docker
===========

This repo use [salt official docker image](https://hub.docker.com/r/saltstack/salt) and split them to a master and two minions. It serves the same purpose as the original one to quick bring up a salt stack to let you verify some concept.

Salt master will auto accept all minions. 

## Salt versions

- Currently pin to 3003


## Get it running

### MacOSX: Change Docker Desktop setting

```
vi ~/Library/Group Containers/group.com.docker/settings.json

...
"deprecatedCgroupv1": true,
...

```

### Salt cluster with docker compose

Using [docker compose](https://github.com/docker/compose) is simplier. Move `docker-compose.yml.example` to `docker-compose.yml` and run:

```
docker-compose up ＆
```

Use same approach `docker exec -it [master_container_id] sh` to jump into salt master container.

## Run

```
$ docker ps -a
CONTAINER ID   IMAGE                   COMMAND                  CREATED         STATUS         PORTS                     NAMES
a7c75cb91596   saltstack/salt:latest   "/usr/bin/dumb-init …"   8 seconds ago   Up 7 seconds   4505-4506/tcp, 8000/tcp   salt-test-stack-minion02-1
7e9f4def641c   saltstack/salt:latest   "/usr/bin/dumb-init …"   8 seconds ago   Up 7 seconds   4505-4506/tcp, 8000/tcp   salt-test-stack-minion01-1
ca2794c65e51   saltstack/salt:latest   "/usr/bin/dumb-init …"   8 seconds ago   Up 7 seconds   4505-4506/tcp, 8000/tcp   salt-test-stack-salt-1

$ docker exec salt-test-stack-salt-1 sh -c 'salt "*" test.ping'
minion02:
    True
minion01:
    True

$ docker exec salt-test-stack-salt-1 sh -c 'salt-key -L'
Accepted Keys:
minion01
minion02
Denied Keys:
Unaccepted Keys:
Rejected Keys:
```

## Notes:

- I can't find `SALT_MASTER_CONFIG` in [salt official docker image](https://hub.docker.com/r/saltstack/salt) clear example, but [this code snippet](https://github.com/librato/salt-state-test/blob/6efe7be8eb2aab21dab4a152e72a8acea2eecedd/test_salt_state.py#L154) inspires me.
- I can't find how to config salt minion either, but `SALT_MINION_CONFIG` could be found in this salt [official repo](https://gitlab.com/saltstack/open/saltdocker/-/blob/master/cicd/docker/saltinit.py#L10). Click the version on the saltstack/salt docker hub page, then go up one directory, then check `saltinit.py`.
