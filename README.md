# archinstall
My personal automated arch linux installation script.

 - **Pre-requisites:**
`Arch Linux ISO` & `Internet Connection`

| Part | Script | Description | Attention |
:-- | :--: | :--: | :--: |
#1 | **base.sh** & **base2.sh** | installs the base system | prompts user & password creation at the end |
#2 | **personal.sh & personal2.sh** | installs my own choice of pkgs & dotfiles | completely unattended |

 ---
# ⚙️ installation
**Part: #1**
 - **Boot the ISO & run:**

    `pacman -Syy`

    `pacman -S git`

    `git clone https://github.com/SheetaI/archinstall && cd archinstall`

    `bash base.sh`
    
  - **Reboot the system**  
    
**Part: #2**

 - **Login and run:**
 
    `git clone https://github.com/SheetaI/archinstall && cd archinstall`
    
    `bash personal.sh`
    
 - **Done!**
 
 ---
 **Todo:**
 - Automate confirmation responses in **base3.sh**
 - Test **base4.sh** as candidate replacement for **base3.sh**
 
