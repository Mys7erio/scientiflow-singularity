FROM nvidia/cuda:12.6.3-runtime-ubuntu22.04

RUN apt update && \
    apt install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Download and the gnina precompiled binarie
RUN wget -qL --show-progress https://github.com/gnina/gnina/releases/download/v1.3/gnina -O /root/gnina && \
    chmod +x /root/gnina


ENTRYPOINT ["/root/gnina"]