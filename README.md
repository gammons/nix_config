# Nix / Nixos config

My nix / nixos config for my daily driver machines.

# Usage

At install time:

```
rm -rf /etc/nixos/*.nix
ln -s nixos/laptop/* /etc/nixos/
nixos-rebuild switch
```

Then in user dir...

```
cp -R config/* ~/.config/
home-manager switch
```

## Sway TODO

- [x] monitor resolution on laptop
- [x] figure out better touchpad scrolling
- [ ] bar
