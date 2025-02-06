# FROM ubuntu:22.04
# FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04
FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install utilities
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y nano vim curl wget python3 python3-pip tzdata nvidia-container-toolkit

# Install nvidia-cuda-toolkit
# RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
#     dpkg -i cuda-keyring_1.1-1_all.deb && \
#     apt-get update && \
#     apt-get -y install cuda-toolkit-12-8


# Install nvidia utils (nvidia-smi) and other utils
RUN apt-get install -y nvidia-utils-570  libglib2.0-0 libglib2.0-data libicu70 libxml2 runc shared-mime-info xdg-user-dirs

# Install go and singularity using the install script
RUN curl https://raw.githubusercontent.com/Mys7erio/scientiflow-singularity/refs/heads/main/install-singularity.sh | bash

# Install scientiflow-cli
RUN pip install --no-cache-dir scientiflow-cli

# Modify singularity configuration file using appropriate settings
RUN sed -i 's/^use nvidia-container-cli = no$/use nvidia-container-cli = yes/' /etc/singularity/singularity.conf
RUN sed -i 's/^# nvidia-container-cli path =/nvidia-container-cli path = \/usr\/bin\/nvidia-container-cli/' /etc/singularity/singularity.conf


