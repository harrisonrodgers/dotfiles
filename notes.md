# Notes

## Fonts

* Update font cache:
```
$ fc-cache -v
```

* If on X then source .Xresources
```
$ xrdb ~/.Xresources
```

## Arch Linux

**Pacman**

* enable [pacman color output ](https://wiki.archlinux.org/index.php/pacman#Color_output) by uncommenting `Color` line in `/etc/pacman.conf`
* enable [pacman - comparing versions before updating ](https://wiki.archlinux.org/index.php/pacman#Comparing_versions_before_updating) by uncommenting `VerbosePkgLists` in `/etc/pacman.conf`

**Booting**

* enable early kms start for open source video drivers [kernel mode setting - archwiki](https://wiki.archlinux.org/index.php/Kernel_mode_setting#Early_KMS_start)
* have boot messages stay on tty1 [disable clearing of boot messages - archwiki](https://wiki.archlinux.org/index.php/disable_clearing_of_boot_messages)

**Makepkg**

* use all cores for compilation [makepkg - archwiki](https://wiki.archlinux.org/index.php/Makepkg#MAKEFLAGS)
* use all cores for compression (or disable compression) [makepkg - archwiki](https://wiki.archlinux.org/index.php/Makepkg#Utilizing_multiple_cores_on_compression)

**Dualboot: Mounting OSX partitions**

* Disable journaling (in OSX) of partition if *write* is desired:
```
$ diskutil disableJournal /Volumes/TheVolumeName
```
* Install the HFS+ utils required for mounting:
```
$ pacman -S hfsprogs
```
* Scan the drive to resolve mount errors before mounting:
```
$ sudo fsck.hfsplus /dev/sda2
```

## Windows
**Dualboot**

* set real time clock to utc instead of loaltime [time - archwiki](https://wiki.archlinux.org/index.php/time#UTC_in_Windows)
* disable fast startup to prevent ntfs mount problems [dual boot with windows - archwiki](https://wiki.archlinux.org/index.php/Dual_boot_with_Windows#Fast_Start-Up)

## OSX

**Remove mouse acceleration** (touching "System Prefernces > Mouse" will restore acceleration) 

```
$ defaults write .GlobalPreferences com.apple.mouse.scaling -1
```
* reboot or log out and back in

## Macbook

**Mute startup chime**

```
$ printf "\x07\x00\x00\x00\x00" > /sys/firmware/efi/efivars/SystemAudioVolume-7c436110-ab2a-4bbb-a880-fe41995c9f82
```

**Reduce boot uefi timeout**

```
$ efibootmgr -t 0
```

**Create boot uefi entry for /dev/sdXY** (remove others using efibootmgr also)

```
$ efibootmgr -c -d /dev/sdX -p Y -l /EFI/refind/refind_x64.efi -L "rEFInd"
```

**Ubuntu Fan: macbook**

* build, install, enable, and start: [mbpfan](https://github.com/dgraziotin/mbpfan)

## Laptops

**Disable power button** (if easily bumped/pressed by accident)

* In: `/etc/systemd/logid.conf` uncomment `HandlePowerKey` and set it to `ignore`.
