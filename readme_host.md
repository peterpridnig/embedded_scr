# pridnig, 22.8.2023

# ---------------------
# -- Serial2USB
# ---------------------

lsusb
Bus 001 Device 015: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC
Bus 001 Device 016: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC
peter@elvwatt:~$ ls -al /dev/serial/by-id/

ls -al /dev/serial/by-path/
Serial I/O
lrwxrwxrwx 1 root root  13 Oct 26 16:03 pci-0000:00:14.0-usb-0:5:1.0-port0 -> ../../ttyUSB0
Debug console:
lrwxrwxrwx 1 root root  13 Oct 26 16:02 pci-0000:00:14.0-usb-0:6:1.0-port0 -> ../../ttyUSB1


# ---------------------
# -- fstab
# ---------------------

/dev/sdb1 on /media/peter/11WATT_0.5T type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096,uhelper=udisks2)
/dev/sdc2 on /media/peter/STORAGE_Volume_11WATT type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096,uhelper=udisks2)
/dev/sda4 on /media/peter/11WATT_SSD0.5T type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096,uhelper=udisks2)

/dev/sdb1: LABEL="11WATT_0.5T" UUID="662872F92872C817" TYPE="ntfs" PARTUUID="0512b30a-01"
/dev/sdc2: LABEL="STORAGE_Volume_11WATT" UUID="96604E02604DE997" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="5bd3007e-e68d-4eb0-a795-1fa2bcdc0a20"
/dev/sda4: LABEL="11WATT_SSD0.5T" UUID="D2CA0BF4CA0BD39F" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="89a179fc-ca6b-468b-a2e9-63a04f4a2b57"

/dev/sdb1: /mnt/backup_0.5t  UUID=662872F92872C817 ntfs
/dev/sdc2: /mnt/storage_1.0t" UUID=96604E02604DE997 "ntfs
/dev/sda4: /mnt/win_ssd0.5t" UUID=D2CA0BF4CA0BD39F ntfs

/etc/fstab
UUID=662872F92872C817 /mnt/backup_0.5t ntfs
UUID=96604E02604DE997 /mnt/storage_1.0t ntfs
UUID=D2CA0BF4CA0BD39F /mnt/win_ssd0.5t ntfs

# ---------------------
# -- GIT
# ---------------------

git log -n 3

$ git commit -m 'initial commit'
$ git add forgotten_file
$ git commit --amend

You end up with a single commit – the second commit replaces the results of the first.

Undo last commit
git checkout -- CONTRIBUTING.md
git status


git remote -v
git remote add scr https://github.com/peterpridnig/scr

git fetch scr
git push scr

git push origin master
(origin=remote, master=branch)

git remote show origin


github fine grained token
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

github personal access token
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


