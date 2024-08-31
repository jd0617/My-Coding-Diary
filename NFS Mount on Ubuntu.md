# NFS Mount on Ubuntu

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
sudo mkdir /mnt/my_share_folder
```
To make this folder be accesseble by multiple users, we need to change the permission of the folder.
```
sudo chmod 777 /mnt/my_share_folder
```

## step 3 - Configuring the NFS Exports on the Host server
```
sudo nano /etc/exports
```
Add lines below to /etc/exports
```
/mnt/my_share_folder  *client_ip*(rw,sync,no_root_squash,no_subtree_check)
```
