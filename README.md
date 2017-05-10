Bloglovin Salt Test
==================

Welcome to Salt Test! 

## Task

1. Fork this project
2. Extend the provided SaltStack stub to automate the process of granting / revoking SSH access to a new developer on a group of server instances.
3. Create a pull request

## Requirements

- Use a feature branch for all of your work.
- Test your code (`salt web01 state.apply test=True` is always a good start)

## Get started

Salt can be tested locally with either Vagrant or Docker. Please use the Makefile to spin up your local environment. 

Test your states against all minions

```
salt \* state.show_highstate
```

## Vagrant (recomended)

```
make install_vagrant
make run_vagrant
```

## Docker

```
make install_docker
make run_docker
```
