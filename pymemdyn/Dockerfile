FROM ubuntu:24.04 AS base


ENV DEBIAN_FRONTEND=noninteractive \
    PYMEMDYN=/root/pymemdyn \
    MAMBA_ROOT_PREFIX=/opt/micromamba


# Update, Install Python3 and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip bzip2 ca-certificates && \
    apt clean && rm -rf /var/apt/lists


# Copy entrypoint script and mark it as executable, finally install micromamba
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN curl -L https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj -C /usr/local/bin --strip-components=1 bin/micromamba && \
    chmod +x /usr/local/bin/entrypoint.sh


# Create a conda environment for rdkit
# RUN micromamba install -y -c conda-forge rdkit && \
#     micromamba clean --all --yes
RUN micromamba create -y -n pyenv_general python=3.12 -c conda-forge \
    rdkit numpy biopython


# Install biopython from pip
# RUN pip install --no-cache --break-system-packages biopython

# Install gromacs from local directory, and extract inside the container
COPY ./gromacs.tar.gz /tmp/gromacs.tar.gz
RUN tar xzvf /tmp/gromacs.tar.gz -C / && \
    rm /tmp/gromacs.tar.gz


# Install PyMemDyn
RUN cd /root && \
    curl -LO https://github.com/GPCR-ModSim/pymemdyn/archive/refs/heads/main.zip && \
    unzip main.zip && \
    mv pymemdyn-main pymemdyn && \
    rm main.zip


# Add pymemdyn executable to path by soft-linking
RUN ln -s /root/pymemdyn/pymemdyn /usr/local/bin/pymemdyn  

 
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh", "/usr/local/bin/pymemdyn" ]