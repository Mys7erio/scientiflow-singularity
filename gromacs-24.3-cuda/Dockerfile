# First stage: Build GROMACS with CUDA support
FROM ubuntu:22.04 AS build

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Kolkata \
    distro=ubuntu2204/x86_64 \
    CUDACXX=/usr/local/cuda/bin/nvcc

# Install necessary packages for building and CUDA
RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    apt-get update && \
    apt-get install -y build-essential git gcc g++ cmake gfortran freeglut3-dev libfftw3-dev libgsl-dev libxml2-dev libopenmpi-dev openmpi-bin python3 python3-pip wget curl

# Add CUDA repository
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    apt-get clean && \
    rm cuda-keyring_1.0-1_all.deb && \
    rm -rf /var/lib/apt/lists/* && \
    apt update


# Install CUDA toolkit
RUN apt-get install -y libnvidia-compute-535 cuda-toolkit-12-0


# Download and build GROMACS
WORKDIR /gromacs
RUN wget https://ftp.gromacs.org/gromacs/gromacs-2024.3.tar.gz && \
    tar xfz gromacs-2024.3.tar.gz

WORKDIR /gromacs/gromacs-2024.3/build

# Configure GROMACS to use CUDA
RUN cmake .. -DGMX_BUILD_OWN_FFTW=ON -DGMX_GPU=CUDA -DREGRESSIONTEST_DOWNLOAD=ON
RUN make -j$(nproc)
RUN make install

# Second stage: Minimal runtime environment with CUDA support
FROM ubuntu:22.04 AS final

ENV DEBIAN_FRONTEND=noninteractive TZ=Asia/Kolkata

# Add CUDA repository
RUN apt-get -y update && \
    apt-get install -y curl && \
    curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb -o cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    rm cuda-keyring_1.0-1_all.deb

# Install necessary libraries and CUDA runtime libraries
RUN apt-get update && \
    apt-get install -y libgsl27 libgslcblas0 libxml2 libfftw3-3 libopenmpi3 openmpi-bin && \
    apt-get install -y cuda-cudart-12-0 libcufft-12-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy GROMACS binaries from the build stage
COPY --from=build /usr/local/gromacs /usr/local/gromacs

# Copy forcefield files from local directory
COPY forcefields/gromos45a3-ptm.ff /usr/local/gromacs/share/gromacs/top/
COPY forcefields/gromos54a7-ptm.ff /usr/local/gromacs/share/gromacs/top/
COPY forcefields/gromos54a8-ptm.ff /usr/local/gromacs/share/gromacs/top/

# Set environment variables
RUN echo "source /usr/local/gromacs/bin/GMXRC.bash" >> /root/.bashrc
RUN echo "source /usr/local/gromacs/bin/GMXRC.bash" >> /etc/profile

# Default command to run GROMACS
ENTRYPOINT ["/usr/local/gromacs/bin/gmx"]

# Labels
LABEL Version="2024.3" Description="GROMACS 2024.3 with CUDA support"
