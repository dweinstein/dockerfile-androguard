# SYNOPSIS

Docker file for building androguard dependencies w/ an **optional** interactive shell environment.


# USAGE

This will use the pre-built image on the public registry (see [this](https://registry.hub.docker.com/u/dweinstein/androguard/))

```shell
$ docker run -t -i dweinstein/androguard /bin/bash
root@1fe111e78fc6:/# /opt/androlyze.sh
```

Similarly this will start the `androlyze` shell by default (the `-v` option is
to mount a folder from the host to the guest):

```shell
$ docker run -t -i -v /path/to/apks:/data dweinstein/androguard
Androlyze version 2.0
In [1]: apk = APK('/data/test.apk')

In [2]: apk.get_activities()
Out[2]: ['com.example.gangrene.GangreneActivity']
```


## BUILD

```shell
$ docker build -t androguard .
```

