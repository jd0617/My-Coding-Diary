sudo apt update && sudo apt upgrade -y

sudo apt install -y dbus-user-session

sudo apt install -y uidmap

sudo systemctl disable --now docker.service docker.socket
sudo rm /var/run/docker.sock

# dockerd-rootless-setuptool.sh install

# export PATH=/usr/bin:$PATH
# export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock

# source ~/.bashrc

# docker info | grep Rootless
