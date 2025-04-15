# Second stage: Minimal runtime environment with CUDA support
FROM nvidia/cuda:12.8.1-runtime-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Kolkata

# Install NVIDIA GPU drivers
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/apt/lists*

# Copy boost version from host to container, and unzip it in the correct location
COPY ./libboost-1.84.tar.gz /libboost-1.84.tar.gz
RUN tar xzvf /libboost-1.84.tar.gz -C /usr/local/lib/ --strip-components 3 && \
    ldconfig

RUN curl -L https://github.com/DeltaGroupNJUPT/Vina-GPU-2.1/raw/refs/heads/main/AutoDock-Vina-GPU-2-1 -o /usr/local/bin/AutoDock-Vina-GPU-2-1 && \
    chmod +x /usr/local/bin/AutoDock-Vina-GPU-2-1

# Default command to run GROMACS
ENTRYPOINT ["/usr/local/bin/AutoDock-Vina-GPU-2-1"]

# Labels
# LABEL Version="2024.3" Description="GROMACS 2024.3 with CUDA runtime"
