FROM debian:jessie
MAINTAINER dweinstein "dweinst@insitusec.com"

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON /usr/bin/python2.7

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends mercurial git python2.7 \
      python-setuptools g++ curl wget zip unzip python-dev libbz2-dev \
      libmuparser-dev libsparsehash-dev python-ptrace python-pygments \
      python-pydot liblzma-dev libsnappy-dev python-pip python-setuptools \
      libc6 libc6-dev libmagic1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    pip install requests yara ipython \
      http://sourceforge.net/projects/pyfuzzy/files/latest/download\?source\=files#pyfuzzy-0.1.0 \
      git+git://github.com/ahupp/python-magic && \
    mkdir -p /tmp/chilkat && \
    wget -qO- http://www.chilkatsoft.com/download/9.5.0.46/chilkat-9.5.0-python-2.7-x86_64-linux.tar.gz \
    | tar xfvz - -C /tmp/chilkat/ && \
    find /tmp/chilkat -type f -exec mv -i "{}" /usr/lib/python2.7/ \; && \
    rm -rf /tmp/chilkat

# obtain latest androguard from master branch
ADD https://github.com/androguard/androguard/archive/master.zip /opt/androguard.zip
RUN cd /opt && unzip androguard.zip && \
    mv /opt/androguard-master /opt/androguard && \
    cd /opt/androguard && python setup.py install && \
    rm -f /opt/androguard.zip

VOLUME /data
WORKDIR /opt/androguard

CMD ["androlyze.py", "-s"]

