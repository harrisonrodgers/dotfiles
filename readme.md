# dotfiles

| area              | selection        | link                                            |
|-------------------|------------------|-------------------------------------------------|
| mouse             | 40cm/360°        |                                                 |
| distribution      | arch linux       | https://www.archlinux.org                       |
| packages (native) | `pacman`         | https://git.archlinux.org/pacman.git/
| packages (aur)    | `rua`            | https://github.com/vn971/rua                    |
| packages (user)   | `nix`            | https://github.com/nixos/nix                    |
| de/wm (wayland)   | `sway`           | https://github.com/swaywm/sway                  |
| de/wm (X11)       | `i3`             | https://github.com/i3/i3                        |
| terminal          | `alacritty`      | https://github.com/alacritty/alacritty          |
| terminal (alt)    | `kitty`          | https://github.com/kovidgoyal/kitty             |
| shell             | `zsh`            | http://zsh.sourceforge.net                      |
| shell manager     | `zplug`          | https://github.com/zplug/zplug                  |
| multiplexer       | `tmux`           | https://github.com/tmux/tmux                    |
| editor            | `neovim`         | https://github.com/neovim/neovim                |
| editor manager    | `vim-plug`       | https://github.com/junegunn/vim-plug            |
| menu              | `rofi`           | https://github.com/davatorium/rofi              |
| media             | `mpv`            | https://github.com/mpv-player/mpv               |
| cat               | `bat`            | https://github.com/sharkdp/bat                  |
| grep              | `ripgrep`        | https://github.com/burntsushi/ripgrep           |
| ls                | `exa`            | https://github.com/ogham/exa                    |
| finder            | `fzf`            | https://github.com/junegunn/fzf                 |
| locker            | `physlock`       | https://github.com/muennich/physlock            |
| colorscheme       | solarized        | https://github.com/altercation/solarized        |
| font (mono)       | Source Code Pro  | https://github.com/adobe-fonts/source-code-pro  |
| font (sans)       | Source Sans Pro  | https://github.com/adobe-fonts/source-sans-pro  |
| font (serif)      | Source Serif Pro | https://github.com/adobe-fonts/source-serif-pro |
| font (editor)     | JetBrains Mono   | https://github.com/JetBrains/JetBrainsMono      |

## Instructions

* Update font cache:
```
$ fc-cache -v
```

* If on X then source .Xresources
```
$ xrdb ~/.Xresources
```

## Editor

**Editor**

* build Dockerfile in `editor` folder
  * arch + aur + nix
  * zsh + tmux + starship
  * ripgrep + fzf + bat + exa + lnav + ...
  * neovim + coc + coc-python + utilsnipts + ...
  * neovim + nvim-lsp + pyls + utilsnips + completion-nvim/diagnostic-nvim

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
