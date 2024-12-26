# Use a suitable base image
FROM python:3.12-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive PYTHONPATH=/root/

RUN apt-get update && apt-get install -y curl libxrender1 libxext6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir numpy lxml openbabel-wheel

# Copy modified PLIP code
COPY ./plip/plip /root/plip

ENTRYPOINT ["python3", "/root/plip/plipcmd.py"]