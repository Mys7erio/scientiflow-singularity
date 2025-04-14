FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt install -y curl build-essential

# Fetch libboost archive, untar it on-the-fly, and redirect the output to /dev/null (For faster processing)
RUN curl -L https://archives.boost.io/release/1.84.0/source/boost_1_84_0.tar.gz | tar xzvf - > /dev/null

# Build libboost 1.84
RUN cd boost_1_84_0 && \
    ./bootstrap.sh && \
    ./b2 install --with=program_options,filesystem --prefix="/usr/local" && \
    tar czvf /libboost.tar.gz /usr/local/lib/libboost_*


ENTRYPOINT ["/bin/bash"]


LABEL Version="1.84"
LABEL Description="This container downloads and builds libboost1.84 from source.  It is solely intended to be used as a utility container to build boost headers and shared libraries, which should be transfered to other containers which require it."