# Software Installed

<pre>
python3         ->  Python 3.10.12 
pip             ->  pip 22.0.2
go              ->  go1.23.1 linux/amd64
singularity     ->  4.2.1-jammy
scientiflow-cli ->  v0.2.10
nvidia-smi      ->  ?
cuda-runtime    ->  cuda 12.8.0
</pre>

## Pseudo sudo

Habituated to typing `sudo` before privilleged commands, or copy-pasting commands from the internet but then it fails because there's no sudo? Well, pseudo sudo to rescue.

What exactly is it? A simple alias `sudo=''`

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

# Run Containers

Running singularity containers inside docker (nested virtualization) requires passing of the --privileged flag

```bash
docker run -it --privileged --gpus all scientiflow/scientiflow-os:v1.0 bash
```

> [!TIP]
> You can also pass the scientiflow root directory to use the same session and containers used by scientiflow-cli on the host

```bash
docker run -it --privileged  -v /home/$USER/.scientiflow:/root/.scientiflow --gpus all scientiflow/scientiflow-os:v1.0 bash
```
