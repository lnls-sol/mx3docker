# MXCuBE3 Docker Container (LNLS/Sirius dev version)

Development Docker container for MXCuBE3 based on Debian 10, aimed at LNLS/Sirius setup.

This is based on the [MXCuBE3 upstream container](https://github.com/mxcube/mx3docker/tree/master/dev/mxcube3/mxcube3-docker-debian9-dev), being customized for documenting LNLS/Sirius beamline configurations, as well as for development and test of new features on them.

The container includes the basic environment (libraries such as Python, EPICs and others), while MXCuBE libraries are mounted on the container, so they can be modified externally with you favorite editor and quickly reloaded for testing.

## Building and runnig the container

The container can be built and run by simply issuing:

```
./build-and-run.sh
```

The name of the image will be mxcube3-dev, as well as the name of the container.

The status can be viewed with:

```
docker ps
```

## Running mxcube3

Launch a shell with:

```
docker exec -it mxcube3-dev bash
```

Then start mxcube3 with:

```
./start-mxcube3-server.sh
```

Point the browser to localhost:8090 to start using MXCuBE3.

The test credentials are:
username: idtest0
password: 000

## Tips
