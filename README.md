# archinstall
My Personal Unattended "Arch Linux" Installer Script.

---
# contents

| Part | Script | Description | Attention | Status |
:-- | :--: | :--: | :--: | :--: |
#1 | **base.sh** & **base2.sh** | installs arch linux base system  | prompts for user & password | working |
#2 | **personal.sh** | installs my choice of pkgs & dotfiles | completely unattended | working |

 ---

# ⚙️ installation

 - **Pre-requisites:**
`Arch Linux ISO` & `Internet Connection`


**Part #1:** 
 - **Boot the ISO & run:**

    `pacman -Syy && yes | pacman -S git`

    `git clone https://github.com/devjessah/archinstall && cd archinstall`
    
    `bash base.sh`
    
 - **Note:** Requires to input user & pass at the end of installation.
      
**Part #2:** [Click here to preview my setup](https://github.com/devjessah/dotfiles)

  *Warning: If you are not me, please configure personal.sh accordingly if you wish to proceed Part #2 without any conflicts.*
    
 - **Login and run:**
 
    `bash /personal.sh`
 
 - **Note:** It will tell you to reboot when everything is done.   
  
# Important:
 The script is designed to autoloop download of packages if it encountered some errors. This will make sure everything is properly downloaded & installed.
 
