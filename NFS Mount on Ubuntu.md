# NFS Mount on Ubuntu

## Reference
- [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-20-04#step-5-creating-mount-points-and-mounting-directories-on-the-client)

## Step 1 - Download and Install the Components
### On the Host Server
```
sudo apt update && sudo apt upgrade -y
sudo apt install nfs-kernel-server
```
### On the Client
```
sudo apt update && sudo apt upgrade -y
sudo apt install nfs-common
```

## Step 2 - Create Share Directories on the Host Server
Make the share directory.
It can be any directory. Here, my shared folder is created under /mnt .
```
sudo mkdir /mnt/host_folder
```
To make this folder be accesseble by multiple users, we need to change the permission of the folder.
```
sudo chmod 777 /mnt/host_folder
```

## Step 3 - Configuring the NFS Exports on the Host server
```
sudo nano /etc/exports
```
Add lines below to /etc/exports
```
/mnt/host_folder  *client_ip*(rw,sync,no_root_squash,no_subtree_check)
```
After save and close the file, restart the NFS server:
```
sudo systemctl restart nfs-kernel-server
```

## Step 4 - Adjusting the Firewall on the Host Server
I recommend to restrict the incoming connections from specific IP address.
```
sudo ufw allow from *client_ip* to any port nfs
```

## Step 5 - Create Mount Points and Mounting Directories on the Client
Here, I use /mnt/client_folder as mouting directory on the client.
```
sudo mkdir /mnt/client_folder
```
```
sudo mount *host_ip:/mnt/host_folder /mnt/client_folder
```

## Step 5.1(Optional) - Testing NFS Access
On client:
```
sudo touch /mnt/client_folder/general.test
```
```
ls -l /mnt/client_folder/general.test
```

## Step 6 - Change permission of Mounting Directories
This is to give every users on the host system permission to read and write files on the mouting directories.
```
sudo chmod 777 /mnt/client_folder
```

## Step 7 - Auto Mount at Boot
On client:
```
sudo nano /etc/fstab
```
Add line(s) below to the file:
```
*host_ip*:/mnt/host_folder  /mnt/client_folder  nfs  auto,nofail,noatime,nolock,intr,tcp,actimeo=1800  0  0
```
Save and close the file.

## Unmounting folder
```
sudo umount *folder_path*
```

END
