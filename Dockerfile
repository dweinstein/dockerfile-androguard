FROM python:2.7

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    curl \
    g++ \
    libbz2-dev \
    liblzma-dev \
    libmagic1 \
    libmuparser-dev \
    libsnappy-dev \
    libsparsehash-dev \
    mercurial \
    python-ptrace \
    python-pydot \
    python-pygments \
    unzip \
    wget \
    zip && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/chilkat && \
    wget -qO- http://www.chilkatsoft.com/download/9.5.0.46/chilkat-9.5.0-python-2.7-x86_64-linux.tar.gz \
    | tar xfvz - -C /tmp/chilkat/ && \
    find /tmp/chilkat -type f -exec mv -i "{}" /usr/local/lib/python2.7/ \; && \
    rm -rf /tmp/chilkat

# python requirements
ADD ./requirements.txt /tmp/requirements.txt
RUN cd /tmp/ && pip install -r requirements.txt

VOLUME /data
WORKDIR /opt/androguard

ENV PYTHON /usr/local/bin/python2.7
CMD ["androlyze.py", "-s"]
