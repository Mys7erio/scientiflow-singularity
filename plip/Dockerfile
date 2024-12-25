FROM python:3.12-slim-bullseye AS build

RUN apt update && apt install -y curl cmake build-essential g++ swig && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    curl -L https://github.com/openbabel/openbabel/archive/refs/tags/openbabel-3-1-1.tar.gz | tar xzf - && \
    cd openbabel-openbabel-3-1-1 && mkdir build && cd build && \
    cmake -DWITH_MAEPARSER=OFF -DWITH_COORDGEN=OFF -DPYTHON_BINDINGS=OFF -DRUN_SWIG=OFF .. && \
    make -j $(nproc) && make install


ENV DEBIAN_FRONTEND=noninteractive PYTHONPATH=/root LD_LIBRARY_PATH=/usr/local/lib
COPY ./plip/plip /root/plip
RUN pip install --no-cache numpy lxml openbabel

# FROM python:3.12-slim-bullseye AS final

# set environment variables
# ENV DEBIAN_FRONTEND=noninteractive PYTHONPATH=/root

# COPY --from=build /usr/local/bin/obabel /usr/local/bin/
# COPY --from=build /usr/local/include/openbabel/ /usr/local/include/openbabel/

# pymol
# RUN apt-get update && apt-get install -y \
#     python3-distutils python3-lxml python3-pymol git && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# COPY ./plip/plip /root/plip
# RUN pip install --no-cache numpy 
    # openbabel requests && \
#     pip install /root/plip


# set entry point to plipcmd.py
ENTRYPOINT  ["python3", "/root/plip/plipcmd.py"]