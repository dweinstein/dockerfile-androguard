FROM dockerfile/ubuntu:latest
MAINTAINER dweinstein "dweinst@insitusec.com"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# androguard dependencies
RUN apt-get install -y mercurial git python2.7 python-setuptools g++ curl wget zip unzip
RUN apt-get install -y python-dev libbz2-dev libmuparser-dev libsparsehash-dev python-ptrace python-pygments python-pydot liblzma-dev libsnappy-dev python-pip

# install IPython
RUN pip install ipython

# install chilkat
RUN wget -qO- http://www.chilkatsoft.com/download/chilkat-9.4.1-python-2.7-x86_64-linux.tar.gz |   tar xfvz - -C /

# install pyfuzzy
RUN pip install http://sourceforge.net/projects/pyfuzzy/files/latest/download\?source\=files#pyfuzzy-0.1.0

# install python magic
RUN pip install git+git://github.com/ahupp/python-magic

# install androguard 
RUN pip install hg+https://androguard.googlecode.com/hg/

# reduce some clutter
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
VOLUME /apks

CMD ["androlyze.py", "-s"]
