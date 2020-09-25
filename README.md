# How to setup a New Server

This tailored for a RaspPi, but most of it is valid for other HW as well.

## Shrink Down the Raspbian

Raspbian by itself is a pretty huge OS, so we will trim it down.

### Remove packages

```
apt -y remove scratch scratch3 java-common libx11-6 vlc-bin lxde-common epiphany-browser libxt6 x11-common nodejs docker wmdocker
apt -y autoremove
```
### Install Needed packages

```
apt -y install vim docker.io git lvm2
```

### Configure Docker to Support Remote Connections

Run the following
```
echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375"' >>/etc/default/docker
systemctl enable docker
systemctl start docker
```

## Attach a Media Drive

Connect it to USB port and power on. Run:
```
fdisk -l
```
Let's assume, that the drive is **/dev/sda**
```
fdisk -l /dev/sda
```
You should see the following (or similar):
```
/dev/sda1   2048 5860532223 5860530176  2.7T Linux filesystem
```
Add to **/etc/fstab** the following lines:
```
LABEL=media /mnt/media ext4 defaults,noatime,nofail 0 0
//192.168.2.20/movies  /mnt/movies/movies  cifs  credentials=/usr/local/etc/movies-credentials,file_mode=0755,dir_mode=0755 0 0
//192.168.2.20/infuse  /mnt/movies/infuse  cifs  credentials=/usr/local/etc/infuse-credentials,file_mode=0755,dir_mode=0755 0 0
```
nofail means that the boot will not fall into recovery mode when the media volume is not available.


And then:
```
mkdir -p /mnt/media /mnt/movies/movies /mnt/movies/infuse
mount /mnt/movies/movies
mount /mnt/movies/infuse
```
If this is successful, you are good to go. If not, let's examine the partition:
```
mount -t ext4 /dev/sda1 /mnt/media
```
If you get the following error: *mount: unknown filesystem type 'LVM2_member'*, the disk is part of (now non-existing) LVM2 group.

Run the following commands, to recreate the LVM:
```
lvscan
```
In the output, you will see our partition. Now re-attach the volume:
```
vgchange -ay
```
Now you can mount the media drive using fstab:
```
mount /mnt/media
```

## Setup a backup-media mount points

Add to **/etc/fstab** the following line:
```
LABEL=backup-media /mnt/backup-media ext4 defaults,noatime,noexec,noauto,nofail 0 0
```
nofail and noauto mean that the backup-media will not mount at startup

Create a mount point:
```
mkdir -p /mnt/backup-media
```

From the cloned "docker" repository (this one), copy the following command:

```
cp ./local/backup/backup-media /usr/local/bin/
chmod +x /usr/local/bin/backup-media
```

## Safe Video Mode

The default video settings of RPi4 are problematic on old monitors. So, let's play it safe:

```
echo "hdmi_safe=1" >>/boot/config.txt
echo "hdmi_mode=1" >>/boot/config.txt
```

## Install Services

* shared-folders
* nasphotos
* movies

