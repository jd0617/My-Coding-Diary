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

## Step 3 - Configuring the NFS Exports on the Host server
```
sudo nano /etc/exports
```
Add lines below to /etc/exports
```
/mnt/my_share_folder  *client_ip*(rw,sync,no_root_squash,no_subtree_check)
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
Here, I use /mnt/shared_folder as mouting directory on the client.
```
sudo mkdir /mnt/shared_folder
```
```
sudo mount *host_ip:/mnt/my_share_folder
```

## (Optional) Testing NFS Access
On client:
```
sudo touch /mnt/my_share_folder/general.test
```
```
ls -l /mnt/my_share_folder/general.test
```









