# Build Stage
FROM nvidia/cuda:12.6.2-devel-ubuntu24.04 AS build

ENV DEBIAN_FRONTEND=noninteractive \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda-12.0/lib64:${LD_LIBRARY_PATH}

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common build-essential cmake wget git python3-pip python3-dev \
    zlib1g-dev libopenbabel-dev libprotobuf-dev protobuf-compiler libboost-all-dev \
    libjsoncpp-dev libeigen3-dev libgoogle-glog-dev libhdf5-dev libatlas-base-dev \
    librdkit-dev python3-numpy libbz2-dev libzstd-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install torch
RUN pip install torch pytest --break-system-packages

# Build GNINA
RUN git clone https://github.com/gnina/gnina.git && \
    cd gnina && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DBUILD_SHARED_LIBS=OFF \
          -DBoost_USE_STATIC_LIBS=ON \
          -DTorch_USE_STATIC_LIBS=ON \
          -DCMAKE_EXE_LINKER_FLAGS="-static" \
          -DCMAKE_PREFIX_PATH=$(python3 -c "import torch; print(torch.utils.cmake_prefix_path)") \
          .. && \
    make -j$(nproc)

# Runtime Stage
FROM nvidia/cuda:12.6.3-base-ubuntu24.04

# Copy statically built binary
COPY --from=build /gnina/ /root/gnina/

# Set entrypoint
ENTRYPOINT ["/root/gnina/bin/gnina"]

# Labels
LABEL Version="1.0" Description="GNINA with CUDA support (statically linked)"
