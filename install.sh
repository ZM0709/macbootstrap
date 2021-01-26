#!/bin/sh
source basic.sh

# if [[ ! -e /usr/local/bin/sslocal ]]; then
#     brew install shadowsocks-libev
#     brew services start shadowsocks-libev
#     ln -s /usr/local/opt/shadowsocks-libev/bin/ss-local /usr/local/bin/sslocal
#     ln -s /usr/local/opt/shadowsocks-libev/bin/ss-server /usr/local/bin/ss-server
# else
#     echo "You have installed shadowsocks"
# fi

# # install and use shadowsocks
# if not_tt_network; then
#     nohup sslocal -c ~/.macbootstrap/tools/netconf &> /private/tmp/nohup.out&
#     #export ALL_PROXY=socks5://127.0.0.1:14179
# else
#     echo "You are in toutiao network, no need to use ss now"
# fi

if [[ ! -e /Applications/iTerm.app ]]; then
    brew install --cask iterm2
    defaults delete com.googlecode.iterm2
    ln -s ~/.macbootstrap/config/com.googlecode.iterm2.plist $HOME/Library/Preferences
    # config background image location
    command="set :New\ Bookmarks:0:Background\ Image\ Location /Users/""$(whoami)""/.macbootstrap/assets/iterm-background.jpg"
    # Disable Background for performance issue
    #/usr/libexec/PlistBuddy -c "$command" $HOME/Library/Preferences/com.googlecode.iterm2.plist
    defaults read -app iTerm >/dev/null
else
    echo "You have installed iTerm2"
fi

if [[ ! -e /Applications/SourceTree.app ]]; then
    brew install --cask sourcetree
else
    echo "You have installed SourceTree"
fi

if [[ ! -e /Applications/WeChat.app ]]; then
    brew install --cask wechat
else
    echo "You have installed WeChat"
fi

if [[ ! -e /Applications/Google\ Chrome.app ]]; then
    brew cask install google-chrome
    # Set Chrome as default browser
    git clone https://github.com/kerma/defaultbrowser ./tools/defaultbrowser
    (cd ./tools/defaultbrowser && make && make install)
    defaultbrowser chrome
    [[ -d ./tools/defaultbrowser ]] && rm -rf ./tools/defaultbrowser
else
    echo "You have installed chrome"
fi

if [[ ! -e /Applications/Visual\ Studio\ Code.app ]]; then
    brew install --cask visual-studio-code
    sh ./vscode/setup.sh
else
    echo "You have installed vscode"
fi

if brew ls --versions gnu-sed > /dev/null; then
    echo "You have installed gsed"
else
    brew install --cask gnu-sed
fi

# install sz/rz
if brew ls --versions lrzsz > /dev/null; then
    echo "You have installed lrzsz"
else
    brew install --cask lrzsz
fi

# install coreutils
if [[ ! -e /usr/local/opt/coreutils ]]; then
    brew install --cask coreutils
    cp /usr/local/opt/coreutils/libexec/gnubin/gls /usr/local/opt/coreutils/libexec/gnubin/ls
else
    echo "You have installed coreutils"
fi

# install jetbrain toolbox
#if [[ ! -e /Applications/JetBrains\ Toolbox.app ]]; then
#    brew cask install jetbrains-toolbox
#else
#    echo "You have installed JetBrains Toolbox"
#fi

brew install --cask --HEAD universal-ctags/universal-ctags/universal-ctags
brew install --cask redis
brew install --cask python3
brew install --cask cmake
brew install --cask gawk
brew install --cask autojump
brew install --cask wget
brew install --cask nvm
brew install --cask exiv2
brew install --cask ssh-copy-id
brew install --cask imagemagick
brew install --cask catimg
brew install --cask gpg
brew install --cask icdiff
brew install --cask scmpuff
brew install --cask fzf
brew install --cask fd
brew install --cask the_silver_searcher
brew install --cask nvim
brew install --cask exiftool
brew install --cask archey
brew install --cask ranger
brew install --cask git-lfs && git lfs install
brew install --cask cloc
$(brew --prefix)/opt/fzf/install --all

# link git config
mv ~/.gitconfig ~/.gitconfig_backup
backup_file ~/.gitattributes
ln -s ~/.macbootstrap/git-config/.gitconfig ~/.gitconfig
ln -s ~/.macbootstrap/git-config/.gitattributes ~/.gitattributes

if [[ ! -e ~/.oh-my-zsh ]]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# zshrc setup
backup_file ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ln -s ~/.macbootstrap/zsh-config/.zshrc ~/.zshrc

# vim configuration
backup_file ~/.vim
backup_file ~/.config/nvim/
git clone https://github.com/bestswifter/vim-config.git ~/.config/nvim
ln -s ~/.config/nvim ~/.vim
backup_file ~/.ideavimrc
ln -s ~/.config/ideavimrc ~/.ideavimrc

# ESLint configuration
backup_file ~/.eslintrc.js
backup_file ~/.eslintrc
ln -s ~/.macbootstrap/.eslintrc.js ~/.eslintrc.js

# Ranger configuration
if [[ ! -e $HEME/.config/ranger ]]; then
    mkdir -p $HOME/.config/ranger
fi
old_commands_py=$HOME/.config/ranger/commands.py
old_rc_conf=$HOME/.config/ranger/rc.conf
backup_file "$old_commands_py"
backup_file "$old_rc_conf"
ln -s ~/.macbootstrap/config/ranger/commands.py "$old_commands_py"
ln -s ~/.macbootstrap/config/ranger/rc.conf "$old_rc_conf"

./install-steps/dependencies.before.sh

unset ALL_PROXY
./install-steps/dependencies.after.sh
sudo ./install-steps/macos.sh
./install-steps/sogou_sync.sh

# ssh configuration
backup_file ~/.ssh/config
if [[ ! -e ~/.ssh ]]; then
    mkdir ~/.ssh
fi
ln -s ~/.macbootstrap/zsh-config/ssh_config ~/.ssh/config

# Personal
./install-steps/personal.sh
./personal.sh

