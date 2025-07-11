FROM mambaorg/micromamba:1.5.1 AS build

# Change user to root because we have to install a few packages from apt
USER root


# libopenmpi-dev is a dev dependency
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential libopenmpi-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 


RUN micromamba -y create python=3.9 \
    -n pyenv \
    -c conda-forge \
    "gmx_MMPBSA==1.6.3" "numpy<1.25" && \
    micromamba clean --all --yes


FROM python:3.9-slim-bookworm AS final


# Install packages which provide necessary shared objects and headers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libopenmpi3 openmpi-bin libgomp1 libatlas-base-dev libhdf5-103 libcurl4 libaec0 libnghttp2-14 libssh2-1 libssl3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


# Copy GMX_MMPBSA andparmed from micromamba build stage so that we don't have to compile it
COPY --from=build /opt/conda/envs/pyenv/lib/python3.9/site-packages/GMXMMPBSA /usr/local/lib/python3.9/site-packages/GMXMMPBSA
COPY --from=build /opt/conda/envs/pyenv/lib/python3.9/site-packages/parmed /usr/local/lib/python3.9/site-packages/parmed


# Installing h5py from pip will save us from installing a lot of dependencies by hand
# Installing mpi4py from pip will require us to build our own wheel. Installing it from anaconda repo to keep image size low
RUN pip install --no-cache h5py pandas tqdm && \
    pip install --no-cache mpi4py -i https://pypi.anaconda.org/mpi4py/simple


# Copy the gmx_MMPBSA executables from the micromamba build stage
COPY --from=build /opt/conda/envs/pyenv/bin/gmx_MMPBSA /usr/local/bin/gmx_MMPBSA
COPY --from=build /opt/conda/envs/pyenv/bin/gmx_MMPBSA_ana /usr/local/bin/gmx_MMPBSA_ana
COPY --from=build /opt/conda/envs/pyenv/bin/gmx_MMPBSA_test /usr/local/bin/gmx_MMPBSA_test


# Install gromacs from local directory, and extract inside the container
COPY ./gromacs.tar.gz /tmp/gromacs.tar.gz
RUN tar xzvf /tmp/gromacs.tar.gz -C / && rm /tmp/gromacs.tar.gz


# Soft link the python3.11 executable to where micromamba executables expect it
# Link gromacs executable to /usr/local/bin
RUN mkdir -p /opt/conda/envs/pyenv/bin/ && \
    ln -s /usr/local/bin/python3.9 /opt/conda/envs/pyenv/bin/python3.9 && \
    ln -s /usr/local/gromacs/bin/gmx /usr/local/bin/gmx


ENTRYPOINT ["/usr/local/bin/gmx_MMPBSA"]
CMD ["-h"]