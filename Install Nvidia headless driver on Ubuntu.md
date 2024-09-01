# Installation of Nvidia GPU headless driver on Ubuntu

## Reference
- [1] https://gist.github.com/wangruohui/bc7b9f424e3d5deb0c0b8bba990b1bc5

## (Optional) Uninstall all previous installations
This step will removing all nvidia related packages include cuda and driver.
This is to avoid possible confilcts in the later installation.
This step is refered from [1].
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
