FROM nvidia/cuda:12.6.2-devel-ubuntu24.04 AS build

ENV DEBIAN_FRONTEND=noninteractive \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-12.0/lib64:${LD_LIBRARY_PATH}

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository universe

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake cmake wget git python3-pip python3-dev zlib1g-dev libopenbabel-dev \
    libprotobuf-dev protobuf-compiler libboost-all-dev libjsoncpp-dev libeigen3-dev libgoogle-glog-dev \
    libhdf5-dev libatlas-base-dev librdkit-dev python3-pytest python3-numpy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Build GNINA
RUN git clone https://github.com/gnina/gnina.git && \
    cd gnina && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF .. && \
    make -j$(nproc)


# Final runtime image
FROM nvidia/cuda:12.6.3-base-ubuntu24.04

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-12.0/lib64:${LD_LIBRARY_PATH}

COPY --from=build /gnina /root
RUN echo "source /root/gnina/bin/gnina" >> ~/.bashrc

# Default command to run GNINA
ENTRYPOINT ["/root/gnina/bin/gnina"]

# Labels
LABEL Version="1.0" Description="GNINA with CUDA support"