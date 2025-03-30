FROM nvidia/cuda:12.8.1-base-ubuntu24.04


ENV DEBAIN_FRONTEND=noninteractive

VOLUME /opt/admet_ai/data

RUN apt update && \
    apt install -y git python3 python3-pip libxrender1

RUN git clone https://github.com/swansonk14/admet_ai /tmp/admet_ai && \
    cd /tmp/admet_ai && \
    pip install --no-cache-dir --break-system-packages .

RUN apt remove -y git && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*


ENTRYPOINT ["/usr/local/bin/admet_predict"]