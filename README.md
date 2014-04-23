dockerfile-androguard
=====================
Docker file for building androguard dependencies w/ an interactive shell
environment.

Put APKs to analyze in `data-container/apks/` directory.

Build
=====

```
➜  dockerfile-androguard git:(master) ✗ make build
docker build -t androguard .
Uploading context 182.3 kB
Uploading context 
Step 0 : FROM ubuntu:12.10
 ---> 0232356d9a18
Step 1 : MAINTAINER David Weinstein <dweinst@insitusec.com>
 ---> Using cache
 ---> 1a2ef7bc70bb
Step 2 : ENV DEBIAN_FRONTEND noninteractive
 ---> Using cache
 ---> 5101abe815ba
Step 3 : RUN apt-get update
 ---> Using cache
 ---> 4c7a0ddfb0c4
Step 4 : RUN apt-get install -y mercurial git python python-setuptools g++ curl wget zip unzip
```

Run
===

```
➜  dockerfile-androguard git:(master) ✗ make run
make -C data-container run
docker run --name androguard_data androguard-data &> /dev/null
make[1]: [run] Error 1 (ignored)
docker run -t -i --rm --volumes-from androguard_data androguard
/usr/local/lib/python2.7/dist-packages/ipython-2.0.0-py2.7.egg/IPython/frontend.py:30: UserWarning: The top-level `frontend` package has been deprecated. All its subpackages have been moved to the top `IPython` level.
  warn("The top-level `frontend` package has been deprecated. "
Androlyze version 2.0
In [1]: apk = APK('/apks/test.apk')

In [2]: apk.get_activities()
Out[2]: ['com.example.gangrene.GangreneActivity']
```
