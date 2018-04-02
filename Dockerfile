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

# python requirements
ADD ./requirements.txt /tmp/requirements.txt
RUN cd /tmp/ && pip install -r requirements.txt

WORKDIR /opt/androguard

ENV PYTHON /usr/local/bin/python2.7
CMD ["androlyze.py", "-s"]
