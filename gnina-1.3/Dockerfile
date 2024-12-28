FROM nvidia/cuda:12.6.3-runtime-ubuntu22.04

RUN apt update && \
    apt install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Download and the gnina precompiled binarie
RUN wget -q --show-progress https://github.com/gnina/gnina/releases/download/v1.3/gnina -O /usr/local/bin/gnina && \
    chmod +x /usr/local/bin/gnina

ENTRYPOINT ["/usr/local/bin/gnina"]