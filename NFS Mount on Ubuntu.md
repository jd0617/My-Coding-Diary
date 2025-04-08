# NFS Mount on Ubuntu

## Reference
- [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-20-04)

## Step 1 - Download and Install the Components
### On the Host Server
```
sudo apt update && sudo apt upgrade -y
sudo apt install nfs-kernel-server -y
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
This is to give every users on the host system permission to read and write files on the mounting directories.
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

## Make folder only accesseble by specific group
Create group if desires group not yet been created:
```
sudo groupadd *mygroup*
```
Add user(s) to the group:
```
sudo usermod -aG -mygroup* *username*
```
Change the group ownership of the folder, here we use chown:
```
sudo chown :*mygroup* /path/to/folder
```
Set group permissions:
Sometime sudo will be needed to perform this step.
For more deatils about using chmod with numbers, please refer to [here](https://help.ubuntu.com/community/FilePermissions#chmod_with_Numbers).


770: Owner and group have full permissions (read, write, execute); others have no access.

750: Owner has full permissions, group has read and execute permissions, others have no access.
```
chmod 770 /path/to/folder
```
Verify permission of folders:
```
ls -l
```


Good Luck!
