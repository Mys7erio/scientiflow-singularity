# Second stage: Minimal runtime environment with CUDA support
FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Kolkata

# Add CUDA repository
RUN apt-get -y update && \
    apt-get install -y curl build-essential && \
    curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb -o cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    rm cuda-keyring_1.0-1_all.deb

# Fetch libboost archive, untar it on-the-fly, and redirect the output to /dev/null (For faster processing)
RUN curl -L https://archives.boost.io/release/1.84.0/source/boost_1_84_0.tar.gz | tar xzvf - > /dev/null

# Build libboost 1.84
RUN cd boost_1_84_0 && \
    ./bootstrap.sh && \
    ./b2 install --with=program_options,filesystem --prefix="/usr/local" && \
    cd .. && \
    rm -rf boost_1_84_0

RUN curl -L https://github.com/DeltaGroupNJUPT/Vina-GPU-2.1/raw/refs/heads/main/AutoDock-Vina-GPU-2-1 -o /usr/local/bin/AutoDock-Vina-GPU-2-1 && \
    chmod +x /usr/local/bin/AutoDock-Vina-GPU-2-1

# Default command to run GROMACS
ENTRYPOINT ["/usr/local/bin/AutoDock-Vina-GPU-2-1"]

# Labels
# LABEL Version="2024.3" Description="GROMACS 2024.3 with CUDA runtime"
