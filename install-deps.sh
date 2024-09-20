# Update package repository and install dependencies
sudo apt update && \
sudo apt install -y cryptsetup-bin libfuse2 uidmap fuse2fs fuse liblzo2-2 squashfs-tools


# Download and install go
wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz

# Add go to PATH permanently
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
source ~/.bashrc

# Download singularity binary specific to ubuntu CODENAME
source /etc/os-release
wget "https://github.com/sylabs/singularity/releases/download/v4.2.1/singularity-ce_4.2.1-${UBUNTU_CODENAME}_amd64.deb"
sudo dpkg -i singularity-ce_4.2.1-${UBUNTU_CODENAME}_amd64.deb
