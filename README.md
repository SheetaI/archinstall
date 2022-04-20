# archinstall
My personal automated arch linux installation script.

 - **Pre-requisites:**
`Arch Linux ISO` & `Internet Connection`

| Part | Script | Description | Attention |
:-- | :--: | :--: | :--: |
#1 | **base.sh** & **base2.sh** | installs arch linux base system | will prompt for username & password at the end |
#2 | **base3.sh** | installs my own choice of pkgs including dotfiles | will prompt for various confirmations |
 ---
**Part: #1**
 - **Boot the ISO & run:**

    `pacman -Syy`

    `pacman -S git`

    `git clone https://github.com/SheetaI/archinstall`

    `cd archinstall`

    `bash base.sh`
    
**Part: #2**
 - **Reboot the system**
 - **Login and run:**
 
    `curl -JLO https://raw.githubusercontent.com/SheetaI/archinstall/master/base3.sh`
    
    `bash base3.sh`
    
 - **Done!**
