# Installing Arch Linux

## Preparation

**Create installer usb**

* Download the latest [archlinux-yyyy.mm.dd-dual.iso](https://www.archlinux.org/download/).

* Create the [usb flash installation media](https://wiki.archlinux.org/index.php/USB_flash_installation_media).

## Installing Arch Linux

**Format the drive**

* Determine the drive identifier (e.g. sdX):
```
$ blkid
```
* Create a new GPT partition table with two partitions with `fdisk`, `gdisk`, or `cgdisk`.

* Make a VFAT filesystem for the EFI:
```
$ mkfs.vfat /dev/sdX1
```

* Make a filesystem for the system:
```
$ mkfs.ext4 /dev/sdX2
```

**Install the base system**

* Move your desired mirrors to the top of the list:
```
$ vim /etc/pacman.d/mirrorlist
```

* Mount the partition for the arch installation:
```
$ mount /dev/sdX2 /mnt
```

* Install the base system and base-devel:
```
$ pacstrap -i /mnt base base-devel
```

* Create `/etc/fstab` using `genfstab`:
```
$ genfstab -U -p /mnt >> /mnt/etc/fstab
```

* Update fstab options:
```
defaults,rw,noatime,nodiscard
```

**Configure the base system**

* Uncomment `en_US.UTF-8 UTF-8` in `/mnt/etc/locale.gen`, then run:
```
$ locale-gen
```

* Create `/mnt/etc/locale.conf` and add:
```
LANG=en_US.UTF-8
```

* Set hostname by writing to `/mnt/etc/hostname`, e.g:
```
arch
```

* Change root into the new system:
```
$ arch-chroot /mnt /bin/bash
```

* Update root password:
```
$ passwd
```

* Create your user account:
```
$ useradd -m -G wheel -s /bin/bash <username>
$ passwd <username>
```

* Install [sudo](https://www.archlinux.org/packages/core/x86_64/sudo/) for temporary privilege escalation:
```
$ pacman -S sudo
```

* Open `/etc/sudoers` and remove the hash before the line:
```
%wheel ALL=(ALL) ALL
```

* Install [net-tools](https://www.archlinux.org/packages/core/x86_64/net-tools/) to use `ifconfig` after rebooting:
```
$ pacman -S net-tools
```

**Setup the bootloader**

* Delete the contents of `/boot`:
```
$ rm -r /boot
```

* Mount the EFI partition to /boot:
```
$ mount /dev/sdX1 /boot
```

* Reinstall linux to recreate the initramfs and vmlinuz-linux files:
```
$ pacman -S linux
```

* Install [intel-ucode](https://www.archlinux.org/packages/extra/any/intel-ucode/) for CPU microcode updates:
```
$ pacman -S intel-ucode
```

* Install the bootloader:
```
$ bootctl install
```

* Update the `/boot/loader/loader.conf` file:
```
timeout 3
default arch
```

* Create a loader entry `/boot/loader/entries/arch.conf`, remembering to add the /dev/sdX2 UUID:
```
title       Arch Linux
linux       /vmlinuz-linux
initrd      /intel-ucode.img
initrd      /initramfs-linux.img
options     root=UUID=puttheuuidhere rw
```

* Or use `genfstab -U /` to obtain the recommended `fstab` entry, alter it as desired, then add it to `/etc/fstab`.

* Reboot.

## Configuring Arch Linux

**Time & Date**

* Set the [timezone](https://wiki.archlinux.org/index.php/time#Time_zone):
```
$ timedatectl set-timezone Australia/Sydney
```

* Enable the network time synchronization service:
```
$ timedatectl set-ntp true
```

* Confirm settings using:
```
$ timedatectl status
```

**Configure internet**

* Create `/etc/systemd/network/ethernet.network` and add:
```
[Match]
Name=enp*

[Network]
DHCP=yes
IPv6PrivacyExtensions=true

[DHCP]
RouteMetric=10
```

* Create `/etc/systemd/network/wireless.network` and add:
```
[Match]
Name=wlp*

[Network]
DHCP=yes
IPv6PrivacyExtensions=true

[DHCP]
RouteMetric=20
```

* Determine the wireless interface name (e.g. wlp3s0):
```
$ ifconfig -a
```

* Create your `/etc/wpa_supplicant/wpa_supplicant-wlp3s0.conf` config:
```
ctrl_interface=/var/run/wpa_supplicant
eapol_version=1
ap_scan=1
fast_reauth=1

network={
    ssid="HomeNetwork"
    psk="passwordhere"
    priority=1
}

network={
    ssid="UniversityNetwork"
    key_mgmt=WPA-EAP
    proto=WPA2
    eap=PEAP
    phase1="tls_disable_tlsv1_2=1"
    phase2="auth=MSCHAPV2"
    identity="username"
    password="password"
    priority=2
}
```

* If desired configure `FallbackDNS` in `/etc/systemd/resolved.conf`.

* Finish off the setup:
```
$ rm /etc/resolv.conf
$ systemctl enable systemd-networkd.service
$ systemctl enable wpa_supplicant@wlp3s0.service
$ systemctl enable systemd-resolved.service
$ systemctl start systemd-networkd.service
$ systemctl start wpa_supplicant@wlp3s0.service
$ systemctl start systemd-resolved.service
$ ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```

* A list of existing links and their status can be found by running:
```
$ networkctl list -a
```

* Information about a specific link can be found using:
```
$ networkctl status wlp3s0
```

**Congigure video**

* Install correct driver, (or all for a portable install):
```
$ pacman -S xorg-drivers mesa mesa-libgl vulkan-intel
```

* Install correct hardware video acceleration drivers:
```
$ pacman -S libva-intel-driver libva-vdpau-driver libva-mesa-driver libvdpau-va-gl mesa-vdpau
```

* To use `vainfo` and `vdpauinfo` to view hardware video acceleration support, install:
```
$ pacman -S libva vdpauinfo
```

## Optional: Bluetooth Keyboard

* Install appropriate software packages:
```
$ pacman -S bluez bluez-utils
```

* Load the generic bluetooth driver, if not already loaded:
```
$ modprobe btusb
```

* Start and enable the `bluetooth.service` systemd unit:
```
$ systemctl start bluetooth.service
$ systemctl enable bluetooth.service
```

* Pair the device from the shell using `bluetoothctl`:

    * Turn the power to the controller on by entering `power on`, it is off by default.

    * Enter `devices` to see the mac address of the devices available to pair.

    * Enter device discovery mode using `scan on` if the device is not in the list yet.

    * Turn the agent on with `agent on`.

    * Enter `pair MAC Address` to do the pairing (tab completion works).

    * If the device does not have a pin, then manually trust the device using `trust MAC Address`.

    * Finally use `connect MAC Address` to establish a connection.

* To ensure power-on after boot, in `/etc/bluetooth/main.conf` set:
```
AutoEnable=True
```

## Optional: Portable Installs

**USB3 boot compatability**

* Incorporate USB3 (XHCI) drivers into the linux intird by adding to `MODULES=""` in `/etc/mkinitcpio.conf`:
```
xhci-hcd
```

* Regenerate the initrd (on a system with a USB3 interface to ensure driver inclusion):
```
$ mkinitcpio -p linux
```

* Explicitly tell the kernel to load and use the XHCI modules by appending the following to the kernel parameters:
```
earlymodules=xhci_hcd modules-load=xhci_hcd
```

**BIOS setting**

* Might have to change USB > Mass Storage Device Emulation Type to `HDD Storage`
