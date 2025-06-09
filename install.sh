#!/bin/bash

RESET="\033[0m"
RED="\033[31m"
BLUE="\033[34m"

BASEDIR=$(dirname "${BASH_SOURCE[0]}")
BASEDIR=$(readlink -f "${BASEDIR}")

pushd "${BASEDIR}"

`which git >/dev/null 2>/dev/null`
if [[ $? -ne 0 ]]; then
    printf "${RED}WARNING: git is not found.  It must be installed before continuing.${RESET}\n"
    read -p "Press Enter to continue, ^C to abort"
fi

if [[ ! -d "${HOME}/bin" ]]; then
    printf "${BLUE}Creating ${HOME}/bin${RESET}\n"
    mkdir "${HOME}/bin"
fi

for I in $(git ls-files bin); do
    TARGET=$(basename "$I")
    if [[ -f "${HOME}/bin/${TARGET}" ]]; then
        EXIST=$(readlink -f "${HOME}/bin/${TARGET}")
    else
        EXIST=""
    fi
    if [[ "${BASEDIR}/bin/${TARGET}" != "${EXIST}" ]]; then
        if [[ -f "${HOME}/bin/${TARGET}" ]]; then
            printf "${RED}${HOME}/bin/${TARGET} exists!${RESET} Backing up as ${BLUE}${HOME}/bin/${TARGET}.backup${RESET}\n"
            mv "${HOME}/bin/${TARGET}" "${HOME}/bin/${TARGET}.backup"
        fi
	ln -s "${BASEDIR}/bin/${TARGET}" "${HOME}/bin/${TARGET}"
    fi
done

for I in $(git ls-files .* | grep -v ".gitignore"); do
    TARGET=$(basename "$I")
    if [[ -f "${HOME}/${TARGET}" ]]; then
        EXIST=$(readlink -f "${HOME}/${TARGET}")
    else
        EXIST=""
    fi
    if [[ "${BASEDIR}/${TARGET}" != "${EXIST}" ]]; then
        if [[ -f "${HOME}/${TARGET}" ]]; then
            printf "${RED}${HOME}/${TARGET} exists!${RESET} Backing up as ${BLUE}${HOME}/${TARGET}.backup${RESET}\n"
            mv "${HOME}/${TARGET}" "${HOME}/${TARGET}.backup"
        fi
	ln -s "${BASEDIR}/${TARGET}" "${HOME}/${TARGET}"
    fi
done

if [[ -d "${HOME}/.config/nvim" ]]; then
    printf "${RED}${HOME}/.config/nvim exists!${RESET} Backing up as ${BLUE}${HOME}/.config/nvim.backup${RESET}\n"
    mv "${HOME}/.config/nvim" "${HOME}/.config/nvim.backup"
fi
ln -s "${BASEDIR}/nvim" "${HOME}/.config/nvim"

mkdir -p "${HOME}/.local/share/konsole"
ln -sf "${BASEDIR}/konsole/Mocha.colorscheme" "${HOME}/.local/share/konsole/Mocha.colorscheme"

touch "${HOME}/.bash_vars"

popd

`which ghcup >/dev/null 2>/dev/null`
if [[ $? -ne 0 ]]; then
    printf "${RED}ghcup not found${RESET}\n"
    echo "ghcup info can be found at: https://www.haskell.org/ghcup/install/"
    echo "Preparing to run the following command:"
    echo " -  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
    read -p "Press Enter to continue, ^C to abort"
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
fi

`which rvm >/dev/null 2>/dev/null`
if [[ $? -ne 0 ]]; then
    printf "${RED}rvm not found${RESET}\n"
    echo "rvm info can be found at: https://rvm.io/rvm/install"
    echo "Preparing to run the following commands:"
    echo " -  gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
    echo " -  curl -sSL https://get.rvm.io | bash -s --ruby"
    read -p "Press Enter to continue, ^C to abort"
    gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
fi

`which elm >/dev/null 2>/dev/null`
if [[ $? -ne 0 ]]; then
    printf "${RED}elm not found${RESET}\n"
    echo "Preparing to run the following commands:"
    echo " -  yarn global add elm"
    read -p "Press Enter to continue, ^C to abort"
    yarn global add elm
fi

# Install nvim plugins
nvim +qall

# Setup legacy vim environment
mkdir -p $HOME/.vim/{backup,tmp,colors}
git clone https://github.com/gmarik/vundle.git "${HOME}/.vim/bundle/vundle"
git clone https://github.com/catppuccin/vim "${HOME}/.vim/catppuccin"
ln -sf "${HOME}/.vim/catppuccin/colors/catppuccin_mocha.vim" "${HOME}/.vim/colors/catppuccin_mocha.vim"
vim -e +BundleInstall +qall
if [[ -d "${HOME}/.vim/bundle/vim-airline/autoload/airline/themes" ]]; then
    ln -sf "${HOME}/.vim/catppuccin/autoload/airline/themes/catppuccin_mocha.vim" "${HOME}/.vim/bundle/vim-airline/autoload/airline/themes/catppuccin_mocha.vim"
fi
