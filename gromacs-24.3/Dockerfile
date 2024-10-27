# First stage: Build environment
FROM ubuntu:22.04 AS build

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Kolkata

RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        gcc \
        g++ \
        cmake \
        gfortran \
        freeglut3-dev \
        libfftw3-dev \
        libgsl-dev \
        libxml2-dev \
        libopenmpi-dev \
        openmpi-bin \
        python3 \
        python3-pip \
        wget \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and build GROMACS
RUN wget https://ftp.gromacs.org/gromacs/gromacs-2024.3.tar.gz && \
    tar xfz gromacs-2024.3.tar.gz && \
    cd gromacs-2024.3 && \
    mkdir build && \
    cd build && \
    cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON && \
    make -j$(nproc) && \
    make install

# Second stage: Minimal runtime environment
FROM ubuntu:22.04 AS final

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Kolkata \
    PATH="/usr/local/gromacs/bin:$PATH"

RUN ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libgsl27 \
        libgslcblas0 \
        libxml2 \
        libfftw3-3 \
        libopenmpi3 \
        openmpi-bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/gromacs /usr/local/gromacs
RUN echo "source /usr/local/gromacs/bin/GMXRC" >> /etc/profile.d/gromacs.sh

# Run GROMACS command
ENTRYPOINT ["gmx"]

# Metadata
LABEL version="2024.3" \
      description="GROMACS 2024.3"

# Example usage help
CMD ["--help"]
