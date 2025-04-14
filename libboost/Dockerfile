FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ARG BOOST_VERSION="1.84.0"

RUN apt-get update && \
    apt install -y curl build-essential

# Fetch libboost archive, untar it on-the-fly, and redirect the output to /dev/null (For faster processing)
RUN BOOST_VERSION_DIR=$(echo $BOOST_VERSION |tr "." "_") && \
    echo "Downloading libboost v$BOOST_VERSION from https://archives.boost.io/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_DIR}.tar.gz" && \
    mkdir /libboost && \
    curl -L https://archives.boost.io/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_DIR}.tar.gz | tar xzvf - -C /libboost --strip-components 1 > /dev/null

# Build libboost 1.84
RUN cd /libboost && \
    ./bootstrap.sh && \
    ./b2 install --with=program_options,filesystem --prefix="/usr/local" && \
    tar czvf /libboost.tar.gz /usr/local/lib/libboost_*


ENTRYPOINT ["/bin/bash"]


LABEL Version="1.84"
LABEL Description="This container downloads and builds libboost1.84 from source.  It is solely intended to be used as a utility container to build boost headers and shared libraries, which should be transfered to other containers which require it."