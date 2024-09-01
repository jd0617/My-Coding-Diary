# Installation of Nvidia GPU headless driver on Ubuntu

## Reference
- [1] https://linuxconfig.org/how-to-disable-blacklist-nouveau-nvidia-driver-on-ubuntu-20-04-focal-fossa-linux
- [2] https://gist.github.com/wangruohui/bc7b9f424e3d5deb0c0b8bba990b1bc5

## Disable and blacklist default Nouveau nvidia driver on Ubuntu
Source: [1]
Step 1 - blacklist Nouveau driver
```
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
```
```
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
```
Step 2 - Confirm the content of the newly created modeprobe file `blacklist-nvidia-nouveau.conf`:
```
cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf
```
It should return 
```
blacklist nouveau
options nouveau modeset=0
```

Step 3 - Update kernel `initramfs` and reboot
```
sudo update-initramfs -u
```
```
sudo reboot
```

## (Optional) Uninstall all previous installations
This step will removing all nvidia related packages include cuda and driver.
This is to avoid possible confilcts in the later installation.
This step is refered from [2].
Remove all installed nvidia packages:
```
sudo apt purge nvidia* -y
```
```
sudo apt autoremove -y
```

Check reamining packages related to nvidia.
```
sudo dpkg -l | grep nvidia
```
If packages remain, remove them by:
```
sudo dpkg -P <package_name>
```
### After that, reboot your machine.

## Install the headless nvidia driver
Search for desired version of driver:
```
sudo apt search nvidia-headless-*
```
Install it. Here, I'll be using headless server driver.
```
sudo apt install nvidia-headless-<version>-server
```
Also, you may want to check the utilization and configure the gpu by nvidia-smi:
```
sudo apt install nvidia-utils-<version>-server
```
Reboot.

Good luck!
