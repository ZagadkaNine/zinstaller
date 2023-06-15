BASE = $(PWD)
LN = ln -vsf
LNDIR = ln -vs
PKGINSTALL = sudo apt-get -y install 
ARCH_PKGINSTALL = sudo pacman -Sy --noconfirm
NPMINSTALL = sudo npm i -g
SNAPINSTALL = sudo snap install
PIPINSTALL = pip install
YAYINSTALL = yay -S --noconfirm
RM = rm -rf
CDSOURCES = cd $(BASE)/sources
CDPACKAGES = cd $(BASE)/packages
GITCLONE = git clone
USER = $(shell whoami)

clean:
	$(RM) $(BASE)/dotfiles/config/nvim/autoload
	$(RM) $(BASE)/node_modules
	$(RM) $(BASE)/sources/*

ubuntu-install: ubuntu-base ubuntu-zsh  
ubuntu-install-zsh: ubuntu-alacritty ubuntu-all-languages ubuntu-neovim user ubuntu-snaps


arch-install: arch-base arch-audio arch-zsh arch-fonts arch-zsh arch-all-languages arch-neovim user arch-yay 
	
regolith-install: regolith-base regolith-python regolith-alacritty rust regolith-npm regolith-neovim user regolith-snaps

#########################################
#
#			System	
#
#########################################
	
ubuntu-base:
	mkdir -p ~/.config
	mkdir -p ~/.local
	mkdir -p ~/.local/bin
	sudo apt-get update && sudo apt-get upgrade
	$(PKGINSTALL) vim git curl rsync dnsmasq net-tools locate software-properties-common cmake libtool m4 pkg-config automake autotools-dev autoconf htop nmon bpytop tmux snapd lm-sensors inxi rfkill blueman bluez bluez-tools pulseaudio-module-bluetooth libsasl2-dev libldap2-dev libssl-dev gimp xpad pgcli postgresql libxkbcommon-dev mesa-utils volumeicon-alsa bpytop python3-venv lsd zsh
	$(PKGINSTALL) nitrogen picom vlc tmux nmon libsasl2-dev gimp xpad  flameshot rtorrent  volumeicon-alsa luajit usb-creator-gtk rofi gnome-screensaver gnome-power-manager acpi neofetch lxappearance gnome-flashback
	

regolith-base:
	mkdir -p ~/.config
	sudo apt-get update && sudo apt-get upgrade
	$(PKGINSTALL) fonts-nerd-font-iosevka vim git curl dnsmasq net-tools locate software-properties-common cmake libtool m4 pkg-config automake autotools-dev autoconf htop nmon bpytop tmux snapd lm-sensors make nmon libtool-bin build-essential gettext cargo plocate

arch-base:
	$(ARCH_PKGINSTALL) pass rsync git curl lightdm lightdm-gtk-greeter lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-pantheon-greeter lightdm-webkit-theme-litarvan lightdm-gtk-greeter-settings picom nitrogen alacritty volumeicon network-manager-applet trayer lxsession xautolock volumeicon lxappearance arc-gtk-theme adapta-gtk-theme arc-solid-gtk-theme deepin-gtk-theme gtk-theme-elementary materia-gtk-theme pop-gtk-theme blueman slock dunst xdotool rofi sudo 
	systemctl enable lightdm
	mkdir -p ~/.config
	$(RM) $(BASE)/sources/yay-git
	$(CDSOURCES) &&	$(GITCLONE) https://aur.archlinux.org/yay-git.git 
	$(CDSOURCES)/yay-git && makepkg -si

#########################################
#
#			Fonts	
#
#########################################

ubuntu-fonts:
	$(RM) ~/.fonts/*
	mkdir -p ~/.fonts
	cd ~/.fonts && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/Iosevka.zip && unzip Iosevka.zip && rm Iosevka.zip
	fc-cache -fv	

arch-fonts:
	$(ARCH_PKGINSTALL) ttc-iosevka ttf-nerd-fonts-symbols-common

#########################################
#
#			Zsh	
#
#########################################

starship:
	curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir $(HOME)/.local/bin --yes
	$(LN) $(BASE)/dotfiles/config/starship.toml $(HOME)/.config/starship.toml

ubuntu-zsh: ubuntu-fonts starship
	$(LN) $(BASE)/dotfiles/config/zsh $(HOME)/.config/zsh
	$(LN) $(BASE)/dotfiles/zshrc $(HOME)/.zshrc
	sudo chsh -s /usr/bin/zsh $(USER)
	zsh -c "make ubuntu-install-zsh"
	
arch-zsh: starship 
	$(ARCH_PKGINSTALL) lsd zsh 
	$(LN) $(BASE)/dotfiles/config/zsh $(HOME)/.config/zsh
	$(LN) $(BASE)/dotfiles/zshrc $(HOME)/.zshrc

regolith-zsh: starship
	$(PKGINSTALL) zsh zsh-theme-powerlevel9k
	$(LN) $(BASE)/dotfiles/config/zsh $(HOME)/.config/zsh
	$(LN) $(BASE)/dotfiles/zshrc $(HOME)/.zshrc

#########################################
#
#			Alacritty	
#
#########################################

ubuntu-alacritty: rust 
	$(PKGINSTALL) cmake libfreetype6-dev libfontconfig1-dev xclip libxcb1-dev
	$(RM) $(BASE)/sources/Alacritty
	$(CDSOURCES) &&	$(GITCLONE) https://github.com/jwilm/Alacritty
	. ~/.cargo/env && $(CDSOURCES)/Alacritty && cargo build --manifest-path Cargo.toml
	sudo mkdir -p /usr/local/share/man/man1
	$(CDSOURCES)/Alacritty && gzip -c alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
	$(CDSOURCES)/Alacritty && sudo cp target/debug/alacritty /usr/local/bin
	$(LN) $(BASE)/dotfiles/config/alacritty $(HOME)/.config/alacritty
	
regolith-alacritty: 
	$(PKGINSTALL) cmake libfreetype6-dev libfontconfig1-dev xclip libxcb1-dev
	$(RM) $(BASE)/sources/Alacritty
	$(CDSOURCES) &&	$(GITCLONE) https://github.com/jwilm/Alacritty
	. ~/.cargo/env && $(CDSOURCES)/Alacritty && cargo run --manifest-path Cargo.toml
	sudo mkdir -p /usr/local/share/man/man1
	$(CDSOURCES)/Alacritty && gzip -c alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
	$(CDSOURCES)/Alacritty && sudo cp target/debug/alacritty /usr/local/bin
	$(LN) $(BASE)/dotfiles/config/alacritty $(HOME)/.config/alacritty


#########################################
#
#			Server	
#
#########################################

ubuntu-gdm:
	$(PKGINSTALL) lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings slick-greeter lxsession xautolock lxappearance slock dunst xdotool 

# arch-lamp:
# 	$(ARCH_PKGINSTALL) apache php-apache mariadb mariadb-clients mod_itk dnsmasq php php-gd php-imagick imagemagick
# 	systemctl enable --now httpd
# 	systemctl enable --now dnsmasq 
# 	systemctl enable --now mariadb
# 	sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
# 	sudo mysql_secure_installation
#     sudo systemctl restart --now mariadb
# 	$(LN) $(BASE)/dotfiles/config/apache $(HOME)/.config/apache

#########################################
#
#			  Drivers	
#
#########################################

arch-audio:
	$(RM) ~/.config/volumeicon
	$(ARCH_PKGINSTALL) alsa-utils alsa-tools alsa-plugins alsa-firmware
	#asoundconf set-default-card Generic
	$(LN) $(BASE)/dotfiles/config/volumeicon $(HOME)/.config/volumeicon


#########################################
#
#				Languages & Frameworks
#
#########################################

ubuntu-all-languages: ubuntu-python rust node 
arch-all-languages: arch-python rust arch-node

node:
	curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - 
	sudo apt update && sudo apt-get install -y nodejs
	
angular:
	sudo npm install -g @angular/cli
	sudo npm install --global sass
	sudo npm install --global less


rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
	. ~/.cargo/env

arch-node:
	$(ARCH_PKGINSTALL) nodejs npm 
	
ubuntu-python:
	$(PKGINSTALL) python3 python3-pip python3-venv python3-ipython python3-psutil

arch-python:
	$(ARCH_PKGINSTALL) python-virtualenvwrapper ipython python-psutil python-pip
	$(PIPINSTALL) python-env 

regolith-python:
	$(PKGINSTALL) python3 python3-pip python3-venv 
	pip3 install ipython psutil

regolith-npm:
	sudo apt install npm
	sudo npm i -g prettier

#########################################
#
#			 IDEs	
#
#########################################

lsp: 
	sudo apt install npm composer
	composer global require php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
	npm i intelephense
	sudo apt-get install fzf


ubuntu-neovim:
	$(PKGINSTALL) ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip fzf
	sudo $(RM) $(BASE)/sources/neovim
	$(CDSOURCES) &&	$(GITCLONE) https://github.com/neovim/neovim.git 
	$(CDSOURCES)/neovim/ && git checkout stable && make CMAKE_BUILD_TYPE=Release && sudo make install
	$(RM) $(HOME)/.config/nvim
	$(LN) $(BASE)/dotfiles/config/nvim $(HOME)/.config/nvim

regolith-neovim:
	$(PKGINSTALL) ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
	sudo $(RM) $(BASE)/sources/neovim
	$(CDSOURCES) &&	$(GITCLONE) https://github.com/neovim/neovim.git 
	$(CDSOURCES)/neovim/ && git checkout stable && sudo make CMAKE_BUILD_TYPE=Release && sudo make install
	$(RM) $(HOME)/.config/nvim
	$(LN) $(BASE)/dotfiles/config/nvim $(HOME)/.config/nvim

arch-neovim: arch-all-languages
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim	
	$(ARCH_PKGINSTALL) neovim ripgrep xsel fzf
	$(RM) $(HOME)/.config/nvim
	$(LN) $(BASE)/dotfiles/config/nvim $(HOME)/.config/nvim

ubuntu-jetbrains:
	$(SNAPINSTALL) webstorm --classic
	$(SNAPINSTALL) pycharm-professional --classic
	$(SNAPINSTALL) phpstorm --classic
	$(SNAPINSTALL) datagrip --classic

#########################################
#
#			  Virtualization
#
#########################################

ubuntu-virtualization:
	$(PKGINSTALL) virtualbox virtualbox-ext-pack 

#########################################
#
#			  I3
#
#########################################

ubuntu-i3:
	$(PKGINSTALL) i3 i3status i3blocks i3pystatus
	$(CDSOURCES) &&	$(GITCLONE) https://github.com/i3-gnome/i3-gnome.git
	$(CDSOURCES)/i3-gnome/ && sudo make install
	
#########################################
#
#			  User
#
#########################################

user: 
	mkdir -p ~/Documents
	mkdir -p ~/Downloads
	cp -rf $(BASE)/wallpapers ~/Documents/
	sudo cp -rf $(BASE)/wallpapers/* /usr/share/backgrounds
	$(RM) $(HOME)/.config/nitrogen
	cp -rf $(BASE)/dotfiles/config/nitrogen $(HOME)/.config/
	$(RM) $(HOME)/.xsessionrc
	$(LN) $(BASE)/dotfiles/xsessionrc $(HOME)/.xsessionrc
	$(RM) $(HOME)/.config/alacritty
	$(LN) $(BASE)/dotfiles/config/alacritty $(HOME)/.config/alacritty
	$(RM) $(HOME)/.config/picom
	$(LN) $(BASE)/dotfiles/config/picom $(HOME)/.config/picom
	$(RM) $(HOME)/.config/rofi
	$(LN) $(BASE)/dotfiles/config/rofi $(HOME)/.config/rofi
	$(RM) $(HOME)/.config/rofi-pass
	$(LN) $(BASE)/dotfiles/config/rofi-pass $(HOME)/.config/rofi-pass
	$(RM) $(HOME)/.config/regolith2
	$(LN) $(BASE)/dotfiles/config/regolith2 $(HOME)/.config/regolith2
	$(RM) $(HOME)/.config/i3blocks
	$(LN) $(BASE)/dotfiles/config/i3blocks $(HOME)/.config/i3blocks
	$(RM) $(HOME)/.config/i3
	$(LN) $(BASE)/dotfiles/config/i3 $(HOME)/.config/i3
	$(RM) $(HOME)/.config/gtk-2.0
	$(LN) $(BASE)/dotfiles/config/gtk-2.0 $(HOME)/.config/gtk-2.0
	$(RM) $(HOME)/.config/gtk-3.0
	$(LN) $(BASE)/dotfiles/config/gtk-3.0 $(HOME)/.config/gtk-3.0
	$(RM) $(HOME)/.config/gtk-4.0
	$(LN) $(BASE)/dotfiles/config/gtk-4.0 $(HOME)/.config/gtk-4.0
	$(LN) $(BASE)/dotfiles/local/bin/addpass $(HOME)/.local/bin/addpass
	$(LN) $(BASE)/dotfiles/local/bin/rofi-pass $(HOME)/.local/bin/rofi-pass
	$(LN) $(BASE)/dotfiles/local/bin/take_screenshot_of_active_windows.bash $(HOME)/.local/bin/take_screenshot_of_active_windows.bash
	$(LN) $(BASE)/dotfiles/local/bin/take_screenshot_of_selected_zone.bash $(HOME)/.local/bin/take_screenshot_of_selected_zone.bash
	$(LN) $(BASE)/dotfiles/local/bin/tmux-sessionizer $(HOME)/.local/bin/tmux-sessionizer


#########################################
#
#			X Apps	
#
#########################################

ubuntu-snaps:
	$(SNAPINSTALL) core
	$(SNAPINSTALL) chromium
	$(SNAPINSTALL) slack --classic
	$(SNAPINSTALL) brave
	$(SNAPINSTALL) enpass
	$(SNAPINSTALL) spotify --classic
	$(SNAPINSTALL) postman --classic

regolith-snaps:
	$(SNAPINSTALL) core
	$(SNAPINSTALL) starship
	$(SNAPINSTALL) chromium
	$(SNAPINSTALL) slack --classic
	$(SNAPINSTALL) brave
	$(SNAPINSTALL) enpass
	$(SNAPINSTALL) spotify --classic
	$(SNAPINSTALL) postman --classic

arch-yay:
	$(YAYINSTALL) slack-desktop 
	$(YAYINSTALL) brave-bin 
	$(YAYINSTALL) onlyoffice-bin 
	$(YAYINSTALL) postman-bin 
	$(YAYINSTALL) lightdm-webkit-theme-aether 





