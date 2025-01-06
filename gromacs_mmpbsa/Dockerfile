FROM ubuntu:24.04 AS base

# Install dependencies and micromamba in a single step
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl bzip2 ca-certificates libgomp1\
    && curl -L https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj -C /usr/local/bin --strip-components=1 bin/micromamba \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set micromamba environment variables
ENV MAMBA_ROOT_PREFIX=/opt/micromamba
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

# Create a conda environment for gmx_MMPBSA and remove cache
RUN micromamba create -y -n gmx_env python=3.8 gmx_MMPBSA && \
    micromamba clean --all --yes

# Set the active environment path
ENV CONDA_DEFAULT_ENV=gmx_env
ENV PATH=/opt/micromamba/envs/gmx_env/bin:$PATH

RUN curl -L https://scientiflow.s3.ap-south-1.amazonaws.com/gromacs.tar.gz |tar xzvf - && \
    ln -s /usr/local/gromacs/bin/gmx /usr/local/bin/gmx && \
    ln -s /opt/micromamba/envs/gmx_env/bin/gmx_MMPBSA /usr/local/bin/gmx_MMPBSA


ENTRYPOINT [ "/usr/local/bin/gmx_MMPBSA" ]
