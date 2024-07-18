<div align="center">
<h1>
❄️ McArthur's NixOS dotfiles ❄️
</h1>
</div>

These are my personal dotfiles. Public, feel free to take inspiration from them or fork.
That said, they will almost certainly require adapting, they are not designed for other people to use. There are secrets, and hardware specific things everywhere.
It is originally based on [this](https://github.com/wimpysworld/nix-config/tree/main) config, though has diverged a lot since.

Home manager and Nixos configurations are seperate. It uses pretty nifty mkHost and mkHome helpers to let me hotswap certain features. Those being the shell, system, username, hostname and desktop.
The only available atm shell/desktop is alucard. It uses *hyprland*, *kitty*, *helix*, etc. Dracula theme, hence the name.

Stylix is done with stylix. Secrets are managed by SOPS.

```mint
    ❄️ NixOS / Home-Manager Configuration ❄️
------------------------------------------------
 ╭─ Hosts
 │  ├─ Benefactor
 │  │  ├─ Hostname -> benefactor
 │  │  ├─ Username -> mcarthur
 │  │  └─ System   -> x86_64-linux
 │  ├─ Grimoire
 │  │  ├─ Hostname -> grimoire
 │  │  ├─ Username -> mcarthur
 │  │  ├─ System   -> x86_64-linux
 │  │  ├─ Desktop  -> alucard
 │  │  └─ Shell    -> alucard
 │  ├─ Mosaic
 │  │  ├─ Hostname -> mosaic
 │  │  ├─ Username -> mcarthur
 │  │  ├─ System   -> x86_64-linux
 │  │  ├─ Desktop  -> alucard
 │  │  └─ Shell    -> alucard
 │  └─ Thaumaturge
 │     ├─ Hostname -> thaumaturge
 │     ├─ Username -> mcarthur
 │     ├─ System   -> x86_64-linux
 │     ├─ Desktop  -> alucard
 │     └─ Shell    -> alucard
 ╭─ Home Configurations
 │  ├─ mcarthur@benefactor
 │  │  ├─ Hostname -> benefactor
 │  │  ├─ Username -> mcarthur
 │  │  ├─ System   -> x86_64-linux
 │  │  └─ Shell    -> alucard
 │  ├─ mcarthur@grimoire
 │  │  ├─ Hostname -> grimoire
 │  │  ├─ Username -> mcarthur
 │  │  ├─ System   -> x86_64-linux
 │  │  ├─ Desktop  -> alucard
 │  │  └─ Shell    -> alucard
 │  ├─ mcarthur@mosaic
 │  │  ├─ Hostname -> mosaic
 │  │  ├─ Username -> mcarthur
 │  │  ├─ System   -> x86_64-linux
 │  │  ├─ Desktop  -> alucard
 │  │  └─ Shell    -> alucard
 │  └─ mcarthur@thaumaturge
 │     ├─ Hostname -> thaumaturge
 │     ├─ Username -> mcarthur
 │     ├─ System   -> x86_64-linux
 │     ├─ Desktop  -> alucard
 │     └─ Shell    -> alucard
 ╭─ Generators
 │  ├─ pi4
 │  │  ├─ Name   -> pi4
 │  │  ├─ System -> aarch64-linux
 │  │  └─ Format -> iso
 │  └─ pi0
 │     ├─ Name   -> pi0
 │     ├─ System -> armv6l-linux
 │     └─ Format -> iso
```

