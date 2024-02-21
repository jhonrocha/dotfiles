# Jhon Dotfiles
My Customizations on Arch

## How to use it
Use `stow` to manage these files.

## Keyring:
Update the `/etc/pam.d/login`: https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring:
```
auth optional pam_gnome_keyring.so
session optional pam_gnome_keyring.so auto_start
```

Start gcr:
```
systemctl --user enable gcr-ssh-agent.service
```
