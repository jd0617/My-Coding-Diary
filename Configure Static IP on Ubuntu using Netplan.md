# Configure Static IP on Ubuntu using Netplan

## Reference
- [1] https://linuxize.com/post/how-to-configure-static-ip-address-on-ubuntu-20-04/

## Step 1 - Idetify the nertwork interface names.
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
