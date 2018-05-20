# rpi-redis
[Redis](http://redis.io) for [Docker](https://www.docker.com/) on the [Raspberry Pi](https://www.raspberrypi.org/).

This repository holds a Dockerfile used for deploying Redis. It is set up with the hope the Dockerfile will be maintained going forward.  
The Dockerfile uses a ARM-friendly base image so that it can be run on a raspberry Pi.

+ Redis : Version 3.2.3
+ Base Image : rpi-alpine-scratch:v3.4. 


# Build
```
git clone git@github.com:Ryan-Gordon/rpi-redis.git
cd rpi-redis
docker build .
```

# Run
```
docker run --name redis ryangordon/rpi-redis
```

#References:

This project was started from [this repo](https://github.com/frozenfoxx/rpi-redis). Head there if you want to get access to the original project. 
