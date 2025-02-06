# Update package repository and install dependencies
apt update && \
apt-get install -y cryptsetup-bin libfuse2 uidmap fuse2fs fuse liblzo2-2 squashfs-tools runc libglib2.0-0

# Source bashrc to update PATH and check if binaries are already available
source ~/.bashrc

# Check if Go is installed
if ! command -v go > /dev/null 2>&1; then
    echo -n "[+] Go not found! Installing Go... "
    curl -sL https://go.dev/dl/go1.23.1.linux-amd64.tar.gz -o /tmp/go1.23.1.linux-amd64.tar.gz
    rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go1.23.1.linux-amd64.tar.gz
    rm /tmp/go1.23.1.linux-amd64.tar.gz

    # Add Go to PATH permanently
    echo -n "Adding to PATH... "
    echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
    echo "Done"
else
    echo "[+] Go is already installed"
fi

# Download singularity binary specific to ubuntu CODENAME
echo -n "[+] Installing Singularity... "
source /etc/os-release
curl -sL "https://github.com/sylabs/singularity/releases/download/v4.2.1/singularity-ce_4.2.1-${UBUNTU_CODENAME}_amd64.deb" -o /tmp/singularity-ce_4.2.1-${UBUNTU_CODENAME}_amd64.deb
dpkg -i /tmp/singularity-ce_4.2.1-${UBUNTU_CODENAME}_amd64.deb
rm /tmp/singularity-ce_4.2.1-${UBUNTU_CODENAME}_amd64.deb
echo "[+] Installation Complete"
