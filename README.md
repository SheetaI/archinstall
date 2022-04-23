# archinstall
My Personal Unattended "Arch Linux" Installer Script.

---
# contents

| Part | Script | Description | Attention | Status |
:-- | :--: | :--: | :--: | :--: |
#1 | **base.sh** & **base2.sh** | installs arch linux base system  | only prompts for user & password | Working |
#2 | **sheetal.sh** | installs my choice of pkgs & dotfiles | completely unattended | Working |

 ---

# ⚙️ installation

 - **Pre-requisites:**
`Arch Linux ISO` & `Internet Connection`


**Part #1:** 
 - **Boot the ISO & run:**

    `pacman -Syy && yes | pacman -S git`

    `git clone https://github.com/SheetaI/archinstall && cd archinstall`
    
    `bash base.sh`
    
 - **Note:** Requires to input user & pass at the end of installation.
      
**Part #2:** [Click here to preview](https://github.com/SheetaI/dotfiles)

 - **Login and run:**
 
    `bash /sheetal.sh`
 
 - **Note:** It will tell you to reboot when its finished.   
 
 - **Done!**
 
# Important:
 The script is designed to autoloop download of packages if it encountered some errors. This will make sure everything is properly downloaded & installed.
 
