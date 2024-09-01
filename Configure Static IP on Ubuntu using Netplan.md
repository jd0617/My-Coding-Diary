# Configure Static IP on Ubuntu using Netplan

## Reference
- [1] https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-20-04/

## Step 1 - Identify the nertwork interface names.
Use command:
```
ip a
```

## Step 2 - Disable cloud-init provision
```
sudo nano /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
```
Add/Change line to the file:
```
network: {config: disabled}
```

## Step 3 - Edit the YAML configuration file:
The configuration file may appear in different filename depends of machines and system.
But it should be located under `/etc/netplan/`.
```
sudo nano /etc/netplan/01-netcfg.yaml
```
In the config file, set dhcp to `no` or `false`. After that, add your IP address information:
```bash
network:
  version: 2
  renderer: networkd
  ethernets:
    <your network interface name>:
      dhcp4: no
      addresses:
        - 192.168.121.221/24
      gateway4: 192.168.121.1
      nameservers:
          addresses: [8.8.8.8, 1.1.1.1]
```
After that save the file with `Ctrl O + Enter` and close the file with `Ctrl + X`.

## Step 4 - Apply the change
After apllying the change, your terminal will be disconnected fomr the server. Just access the server with the newly set static IP address.
Also, you may want to ensure no sending or receiving of files such as dataset before you apply the change as it will be interrupted.
```
sudo netplan apply
```

Good luck!
