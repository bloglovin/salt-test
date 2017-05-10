FROM        ubuntu:14.04

# Update system && install salt + deps
RUN apt-get update && \
    apt-get install -y -o DPkg::Options::=--force-confold wget && \
    echo deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main | tee /etc/apt/sources.list.d/saltstack.list && \
    wget -q -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y -o DPkg::Options::=--force-confold \
      curl \
      dnsutils \
      python-pip \
      python-dev \
      python-apt \
      software-properties-common \
      dmidecode \
      salt-master \
      salt-minion \
      salt-cloud \
      salt-api && \
  apt-get -yqq autoclean && \
  apt-get -yqq autoremove && \
  rm -rf /var/lib/apt/lists/*

# Add salt config files
COPY Vagrant/saltstack/etc/master /etc/salt/master
COPY Vagrant/saltstack/etc/minion1 /etc/salt/minion
RUN sed -i 's/192.168.60.10/master/g' /etc/salt/minion

# Expose volumes
VOLUME ["/etc/salt", "/var/cache/salt", "/var/logs/salt", "/srv/salt"]

# Exposing salt master and api ports
EXPOSE 4505 4506 8000

# Show salt versions
RUN salt --versions

# Add and set start script
COPY run.sh /run.sh
CMD ["bash", "run.sh"]
