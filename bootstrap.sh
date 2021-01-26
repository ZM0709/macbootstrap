#!bin/bash
# [ -z "${BRANCH}" ] && export BRANCH="master"

# if [[ -e ~/.macbootstrap ]]; then
#   rm -rf ~/.macbootstrap
# fi

# if [[ ! -e /usr/local/bin/brew ]]; then
#   /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
# else
#     echo "You have installed brew"
# fi

# brew install git

git clone --depth=1 -b ${BRANCH} https://github.com/zhanggm79/macbootstrap.git ~/.macbootstrap
cd ~/.macbootstrap
bash install.sh
