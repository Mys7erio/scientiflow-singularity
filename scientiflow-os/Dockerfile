# FROM ubuntu:22.04
FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04

# Update and install utilities
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y nano vim curl wget python3 python3-pip

# Install nvidia-cuda-toolkit
# RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
#     dpkg -i cuda-keyring_1.1-1_all.deb && \
#     apt-get update && \
#     apt-get -y install cuda-toolkit-12-8


# Install nvidia utils (nvidia-smi) and other utils
RUN apt-get install -y nvidia-utils-570

# Install go and singularity using the install script
RUN curl https://raw.githubusercontent.com/Mys7erio/scientiflow-singularity/refs/heads/main/install-singularity.sh | bash
