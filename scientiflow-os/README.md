# Run containers

Running singularity containers inside docker (nested virtualization) requires passing of the --privilleged flag

```bash
docker run -it --privilleged --gpus all scientiflow/os:v0.1 bash
```


# Software installed

 - python3
 - pip3
 - go
 - singularity
 - nvcc
 - nvidia-smi
 - cuda-runtime


# Host Requirements

## NVIDIA GPU Drivers
Check for package: `nvidia-driver-VERSION`


## NVIDIA Container Toolkit
Install using:
```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
  
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update

sudo apt-get install -y nvidia-container-toolkit
```

Enable the container runtime for docker, and validate using:
```bash
sudo nvidia-ctk runtime configure --runtime=docker
nvidia-ctk runtime validate
```

Testing the configurtion:
```bash
docker run --rm --gpus all nvidia/cuda:12.8.0-cudnn-runtime-ubuntu22.04 nvidia-smi
```