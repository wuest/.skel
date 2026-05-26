#!/usr/bin/bash

# shellcheck disable=SC2059

RESET="\033[0m"
RED="\033[31m"

if ! eval "$(which gchup) -h"; then
    printf "${RED}ghcup not found${RESET}\n"
    echo "ghcup info can be found at: https://www.haskell.org/ghcup/install/"
    echo "Preparing to run the following command:"
    echo " -  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
fi

if ! eval "$(which rvm) -h" && ! eval "$(which rbenv) -h"; then
    printf "${RED}rvm not found${RESET}\n"
    echo "rvm info can be found at: https://rvm.io/rvm/install"
    echo "Preparing to run the following commands:"
    echo " -  gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
    echo " -  curl -sSL https://get.rvm.io | bash -s --ruby"
    gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
fi

if ! eval "$(which elm)"; then
    printf "${RED}elm not found${RESET}\n"
    echo "Preparing to run the following commands:"
    echo " -  yarn global add elm"
    yarn global add elm
fi
