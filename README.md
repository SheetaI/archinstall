# archinstall
My personal automated arch linux installation script.

 - **Pre-requisites:**
`Arch Linux ISO` & `Internet Connection`

| Part | Script | Description | Attention | Status | 
:-- | :--: | :--: | :--: | :--: |
#1 | **base.sh** & **base2.sh** | installs the base system | prompts user & password creation at the end | Working |
#2 | **sheetal.sh** | installs my choice of pkgs & dotfiles | prompts for AUR pkgs confirmations | Working |
#3 | **dev-sheetal.sh** | ongoing project | make pacman loop & auto respond AUR prompts | Not working|
 ---
# ⚙️ installation
**Part: #1**
 - **Boot the ISO & run:**

    `pacman -Syy && pacman -S git`

    `git clone https://github.com/SheetaI/archinstall && cd archinstall`
    
    `bash base.sh`
    
  - **Reboot the system**  
    
**Part: #2**

 - **Login and run:**
 
   `sudo mv /sheetal.sh $HOME`
   
   `bash sheetal.sh`
    
 - **Done!**
 
 ---
 **Todo:**
- Work on unattended installation **dev-sheetal.sh**
