FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade && apt-get clean
RUN apt-get install -y --force-yes \
    build-essential \
	libelf-dev \
	make \
	python \
	python-pip \
	runit \
	unzip \
	wget &&\
	apt-get clean

COPY entrypoint.sh /
COPY build.sh /

COPY gcc4ti /gcc4ti
WORKDIR /gcc4ti/trunk/tigcc-linux/scripts
RUN bash ./updatesrc
WORKDIR /gcc4ti/trunk/tigcc-linux/gcc4ti-0.96b11
RUN bash scripts/Install

RUN mkdir /work
WORKDIR /work

ENTRYPOINT ["/entrypoint.sh"]
