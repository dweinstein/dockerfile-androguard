FROM dockerfile/ubuntu:latest
MAINTAINER dweinstein "dweinst@insitusec.com"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# androguard dependencies
RUN apt-get install -y mercurial git python2.7 python-setuptools g++ curl wget zip unzip
RUN apt-get install -y python-dev libbz2-dev libmuparser-dev libsparsehash-dev python-ptrace python-pygments python-pydot liblzma-dev libsnappy-dev python-pip

# clone the androguard repo
RUN hg clone https://androguard.googlecode.com/hg/ /opt/androguard

# install IPython (optional?)
RUN apt-get install -y python-setuptools
RUN easy_install ipython

# install chilkat
RUN cd /opt/androguard/ && wget http://www.chilkatsoft.com/download/chilkat-9.4.1-python-2.7-x86_64-linux.tar.gz && tar xfvz chilkat-9.4.1-python-2.7-x86_64-linux.tar.gz
RUN cp /opt/androguard/usr/local/lib/python2.7/site-packages/* /usr/lib/python2.7/

# install pyfuzzy
RUN curl -L http://sourceforge.net/projects/pyfuzzy/files/latest/download\?source\=files -o /opt/androguard/pyfuzzy.tar.gz
RUN cd /opt/androguard && tar -zxvf pyfuzzy.tar.gz && cd pyfuzzy-0.1.0 && python setup.py install

# install python magic
RUN cd /opt/androguard && git clone git://github.com/ahupp/python-magic.git && cd python-magic && python setup.py install

RUN cd /opt/androguard && python setup.py install

# reduce some clutter
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
VOLUME /apks

CMD ["androlyze.py", "-s"]
