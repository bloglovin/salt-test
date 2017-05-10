install: install_docker install_vagrant

UNAME_S := $(shell uname -s)
DOCKER_ENGINE := $(shell command -v docker 2> /dev/null)
DOCKER_COMPOSE := $(shell command -v docker-compose 2> /dev/null)
VAGRANT := $(shell command -v vagrant 2> /dev/null)
VIRTUALBOX := $(shell command -v virtualbox 2> /dev/null)
VAGRANT_SALT := $(shell vagrant plugin list | grep salt 2> /dev/null)

install_docker:
ifeq ($(UNAME_S), Darwin)
	brew install docker-machine docker-compose
	docker-machine create --driver virtualbox salt
	eval "$(docker-machine env salt)"
endif
ifeq ($(UNAME_S), Linux)
ifndef DOCKER_ENGINE
	apt-get -y update
	apt-get -y install apt-transport-https ca-certificates
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	echo "deb https://apt.dockerproject.org/repo debian-$(lsb_release -cs) main" > /etc/apt/sources.list.d/docker.list
	apt-get -y update
	apt-get -y install docker-engine
endif
ifndef DOCKER_COMPOSE
	curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
endif
endif

install_vagrant:
ifeq ($(UNAME_S),Darwin)
ifndef VIRTUALBOX
	brew cask install virtualbox
endif
ifndef VAGRANT
	brew cask install vagrant
endif
endif
ifeq ($(UNAME_S), Linux)
ifndef VIRTUALBOX
	apt-get install virtualbox
endif
ifndef VAGRANT
	apt-get install vagrant
endif
endif
ifndef VAGRANT_SALT
	vagrant plugin install vagrant-salt
endif

run_vagrant:
	cd Vagrant; vagrant up
	cd Vagrant; vagrant ssh master

run_docker:
ifeq ($(UNAME_S),Darwin)
	eval "$(docker-machine env salt)"
endif
	docker-compose up -d
	docker exec -it saltpoc_master_1 bash

build:
ifeq ($(UNAME_S),Darwin)
	eval "$(docker-machine env salt)"
endif
	docker build -t bloglovin/saltstack .
