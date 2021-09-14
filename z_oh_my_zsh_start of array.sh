#!/bin/bash
#
# Put in user_scripts plugin
# and have it run everytime the araay starts
#
# umask setup
umask 077

# Variable Setup
HOME=/root
CONFIG=/boot/config/ssh
HOME_SSH=/root/.ssh
ZSH="/root/.oh-my-zsh"
OH_MY_ZSH_ROOT="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
OH_MY_ZSH_PLUGINS="$ZSH_CUSTOM/plugins"
OH_MY_ZSH_THEMES="$ZSH_CUSTOM/themes"

### Copy your ssh keys from usb to system
mkdir -p $HOME_SSH
cp $CONFIG/pre-set/* $HOME_SSH
chmod 700 $HOME_SSH
chmod 644 $HOME_SSH/id_rsa.pub
chmod 600 $HOME_SSH/id_rsa
chmod 600 $HOME_SSH/authorized_keys

### Install zsh shits
HOME="/root"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
umask g-w,o-w
chsh -s $(which zsh)
env zsh -l

newplugins="git tmux zsh-autosuggestions zsh-syntax-highlighting"

sed -i  "s/(git)/($newplugins)/" /root/.zshrc
sed -i "s#\(ZSH_THEME *= *\).*#\1agnoster#" /root/.zshrc
echo "cd /mnt/user/" >> /root/.zshrc
echo alias size='du -c -h -d 1 | sort -h' >> /root/.zshrc

# Install zsh-autosuggestions
if [ ! -d "$OH_MY_ZSH_PLUGINS/zsh-autosuggestions" ]; then
        echo "  -> Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions $OH_MY_ZSH_PLUGINS/zsh-autosuggestions
else
        echo "  -> zsh-autosuggestions already installed"
fi

# Install zsh-syntax-highlighting
if [ ! -d "$OH_MY_ZSH_PLUGINS/zsh-syntax-highlighting" ]; then
        echo "  -> Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OH_MY_ZSH_PLUGINS/zsh-syntax-highlighting
else
        echo "  -> zsh-syntax-highlighting already installed"
fi
chmod 700 $OH_MY_ZSH_PLUGINS/zsh-autosuggestions
chmod 700 $OH_MY_ZSH_PLUGINS/zsh-syntax-highlighting
###

# Copy terminal (zsh) history
cp /boot/config/.zsh_history /root