FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install utilities
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y nano vim curl wget tmux python3 python3-pip tzdata nvidia-container-toolkit 


# Install nvidia utils (nvidia-smi) and other utils
RUN apt-get install -y nvidia-utils-550  libglib2.0-0 libglib2.0-data libicu70 libxml2 runc shared-mime-info xdg-user-dirs

# Install go and singularity using the install script
RUN curl https://raw.githubusercontent.com/Mys7erio/scientiflow-singularity/refs/heads/main/install-singularity.sh | bash

# Install scientiflow-cli
RUN pip install --no-cache-dir scientiflow-cli

# Exporting custom aliases, and add custom tmux config
RUN echo "alias sudo=''" > /root/.bashrc && \
    curl -s https://gist.githubusercontent.com/Mys7erio/8c54af5bb128f171c4e0a77de4ccf426/raw/8c75689bdf547e60244c224b998760b8b9464a04/.tmux.conf -o ~/.tmux.conf && \
    echo "export PS1='\[\e[0;38;5;82m\]$ \[\e[0;38;5;45m\]\u \[\e[0;38;5;45m\](\[\e[0;38;5;39m\]\W\[\e[0;38;5;45m\]) \[\e[0;1;38;5;45m\]>\[\e[0m\] '" >> /root/.bashrc



# Modify singularity configuration file using appropriate settings
RUN sed -i 's/^use nvidia-container-cli = no$/use nvidia-container-cli = yes/' /etc/singularity/singularity.conf
RUN sed -i 's/^# nvidia-container-cli path =/nvidia-container-cli path = \/usr\/bin\/nvidia-container-cli/' /etc/singularity/singularity.conf


ENTRYPOINT ["/bin/bash"]
