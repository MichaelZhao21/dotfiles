# My dotfiles!

I have written my own script to backup the dotfiles. All my dotfiles (and other config files) are stored in the [df](./df/) directory. The [files](./files) text file contains the list of directories/files to store.

## Files config format

Each line represents a directory to backup/store. Each relative path is relative to the `$HOME` directory. For absolute paths, start them with a slash character (`/`).

To include multiple files/directories from the same directory, you can use a section to prefix all files from that directory. See the following example:

```
bin                 -> $HOME/bin

[.config]
dunst               -> $HOME/.config/dunst
i3                  -> $HOME/.config/i3

[scripts]
something_cool      -> $HOME/scripts/something_cool

/etc/udev/rules.d   -> /etc/udev/rules.d
```

Note in the previous example, the `-> ...` is not part of the config and only to show what the path represents.

## Usage

To back up your own dotfiles, make a copy of this repo and delete the `df` directory. Then, modify the `files` directory to the dotfiles you want to back up yourself.

Save your dotfiles with:

```bash
go run . save
```

And load your dotfiles with:

```bash
go run .
```

## MY dotfiles

Here is a (almost) comprehensive list of all my dotfiles/config files. These are the specs of my current system (thanks to [hyfetch](https://github.com/hykilpikonna/hyfetch)):

```
                                  mikey@spectre 
       _,met$$$$$gg.              ------------- 
    ,g$$$$$$$$$$$$$$$P.           OS: Debian GNU/Linux 12.5 (bookworm) x86_64 
  ,g$$P"        "\""Y$$.".        Host: HP Spectre x360 Convertible 15-eb0xxx 
 ,$$P'              `$$$.         Kernel: 6.1.0-21-amd64 
',$$P       ,ggs.     `$$b:       Uptime: way too long smh
`d$$'     ,$P"'   .    $$$        Packages: also way too many TT
 $$P      d$'     ,    $$P        Shell: zsh 5.9 
 $$:      $$.   -    ,d$$'        Resolution: 3840x2160 @ 60.00Hz (oop 4k laptop monitor)
 $$;      Y$b._   _,d$P'          WM: i3 
 Y$$.    `.`"Y$$$$P"'             Terminal: x-terminal-emulator
 `$$b      "-.__                  CPU: Intel i7-10750H (12) @ 5.0GHz 
  `Y$$                            GPU: NVIDIA GeForce GTX 1650 Ti Mobile 
   `Y$$.                          GPU: Intel CometLake-H GT2 [UHD Graphics] 
     `$$b.                        Memory: never enough TT
       `Y$$b.                     Network: Wifi6 
          `"Y$b._                 Bluetooth: Intel Corp. AX201 
              `"\""               BIOS: AMI 15.16 (11/02/2022)
```

### Bin scripts

- **bin/lock** - simple 1 liner to configure i3 lock UI
- **bin/monitors** - configure multiple monitors; I have a 4k laptop screen, so doing the DPI and xrandr config is annoying with HD monitors. This script runs on startup and users can run it whenever they plug in/unplug monitors. It's a little annoying bc apps don't autoscale and need to be restarted.

### General configs

- **.zshrc** - Main zsh config file, mostly just loading plugins for [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- **.zshenv** and **.zshprofile** - idk what these are for exactly but some programs like to put their paths here
- **.vim/** - directory with all the vim stuff like colors and plugins
- **.vimrc** - Vim config!!

### Config directory
- **.config/i3/config** - i3 config file
- **.config/polybar/launch.sh** - Main script to launch polybar, checks for multi monitor, DPI, and kills running instances
- **.config/polybar/config.ini** - polybar config file
- **.config/dunst/dunstrc** - dunst config file
- **.config/hyfetch.json** - hyfetch config file
- **.config/rofi/config.rasi** - rofi config file
