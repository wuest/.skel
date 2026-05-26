#!/bin/bash

# shellcheck disable=SC2059

RESET="\033[0m"
RED="\033[31m"
BLUE="\033[34m"

BASEDIR=$(dirname "${BASH_SOURCE[0]}")
BASEDIR=$(readlink -f "${BASEDIR}")

pushd "${BASEDIR}" || exit

if ! $(which git) -h; then
    printf "${RED}WARNING: git is not found.  It must be installed before continuing.${RESET}\n"
    read -rp "Press Enter to continue, ^C to abort"
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

popd || exit

# Install nvim plugins
nvim +qall

# Setup legacy vim environment
mkdir -p "${HOME}"/.vim/{backup,tmp,colors}
git clone https://github.com/gmarik/vundle.git "${HOME}/.vim/bundle/vundle"
git clone https://github.com/catppuccin/vim "${HOME}/.vim/catppuccin"
ln -sf "${HOME}/.vim/catppuccin/colors/catppuccin_mocha.vim" "${HOME}/.vim/colors/catppuccin_mocha.vim"
vim -e +BundleInstall +qall

if [[ -d "${HOME}/.vim/bundle/vim-airline/autoload/airline/themes" ]]; then
    ln -sf "${HOME}/.vim/catppuccin/autoload/airline/themes/catppuccin_mocha.vim" "${HOME}/.vim/bundle/vim-airline/autoload/airline/themes/catppuccin_mocha.vim"
fi

echo "Setup complete, run install_langs.sh to install language support"
echo
