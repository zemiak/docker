# How to setup a New Server

This tailored for a RaspPi, but most of it is valid for other HW as well.

## Shrink Down the Raspbian

Raspbian by itself is a pretty huge OS, so we will trim it down.

### Remove packages

```
apt -y remove scratch scratch3 java-common libx11-6 vlc-bin lxde-common epiphany-browser libxt6 x11-common nodejs openjdk-11-jre docker wmdocker
apt -y autoremove
```
### Install Needed packages

```
apt -y install vim docker.io git lvm2
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
Add to **/etc/fstab** the following line:
```
LABEL=media /mnt/media ext4 defaults,noatime 0 0
```
And then:
```
mount /mnt/media
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

## Install Services

* shared-folders
* nasphotos
* movies

