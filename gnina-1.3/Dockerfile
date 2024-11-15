# First stage: Build stage for dependencies and software installation
FROM ubuntu:22.04 AS build

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Kolkata \
    CUDACXX=/usr/local/cuda/bin/nvcc

# Install essential packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    libboost-all-dev \
    libeigen3-dev \
    libgoogle-glog-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libhdf5-dev \
    libatlas-base-dev \
    python3-dev \
    librdkit-dev \
    python3-numpy \
    python3-pip \
    python3-pytest \
    swig \
    git-all \
    curl \
    libjsoncpp-dev

# Add CUDA repository and install CUDA toolkit
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    apt-get update && \
    apt-get install -y libnvidia-compute-535 cuda-toolkit-12-0 && \
    rm -rf /var/lib/apt/lists/* && \
    rm cuda-keyring_1.0-1_all.deb

# Install Python dependencies
RUN pip3 install --upgrade pip && \
    pip3 install \
    cmake \
    scikit-image \
    pyquaternion \
    google-api-python-client \
    six \
    torch torchvision torchaudio

# Clone and build openbabel
RUN git clone https://github.com/openbabel/openbabel.git && \
    cd openbabel && \
    git checkout openbabel-3-1-1 && \
    mkdir build && cd build && \
    cmake -DWITH_MAEPARSER=OFF -DWITH_COORDGEN=OFF -DPYTHON_BINDINGS=ON -DRUN_SWIG=ON .. && \
    make -j4 && make install

# Clone and build gnina
RUN git clone https://github.com/gnina/gnina.git && \
    cd gnina && \
    mkdir build && cd build && \
    cmake .. && \
    make -j4 && make install

# Second stage: Minimal runtime environment with CUDA support
FROM ubuntu:22.04 AS final

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Kolkata

# Add CUDA repository and install CUDA runtime libraries
RUN apt-get update && \
    apt-get install -y curl && \
    curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb -o cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    rm cuda-keyring_1.0-1_all.deb

# Install necessary runtime libraries and CUDA runtime
RUN apt-get update && \
    apt-get install -y \
    libgsl27 \
    libgslcblas0 \
    libxml2 \
    libfftw3-3 \
    libopenmpi3 \
    openmpi-bin \
    cuda-cudart-12-0 \
    libcufft-12-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy installed binaries and files from the build stage
COPY --from=build /root /root

# Set environment variables to run software
RUN echo "source /root/openbabel/bin/obabel" >> ~/.bashrc
RUN echo "source /root/gnina/bin/gnina" >> ~/.bashrc

# Default command to run GNINA
ENTRYPOINT ["/root/gnina/bin/gnina"]

# Labels
LABEL Version="1.0" Description="OpenBabel and GNINA with CUDA support"

