#!/bin/bash
#
# Put in user_scripts plugin
# and have it run everytime the araay stops
#
# Copy terminal (zsh) history
touch /boot/config/.zsh_history
echo "$(cat /root/.zsh_history)" >> /boot/config/.zsh_history

# Variable Setup
CONFIG=/boot/config/ssh
HOME_SSH=/root/.ssh
# Copy any new keys on exit
rsync -avhW $HOME_SSH/ $CONFIG/pre-set