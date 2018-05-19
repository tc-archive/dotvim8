#!/bin/bash

# Install the 'minpac' Vim configuration.

VIMCONFIG="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VIMRC=${HOME}/.vimrc

# Create symlink to .vimrc
if [ ! -f "${VIMRC}" ]; then
    ln -s ${HOME}/.vim/minpack-vimrc ${HOME}/.vimrc
else
    echo ""${VIMRC} already exists."" 1>&2
fi

# Install minpac package manager
if [ ! -d "${VIMCONFIG}/pack/minpac/opt/minpac" ]; then
    mkdir -p ${VIMCONFIG}/pack/minpac/opt
    pushd ${VIMCONFIG}/pack/minpac/opt > /dev/null
    git clone https://github.com/k-takata/minpac.git
    popd  > /dev/null
else
    pushd ${VIMCONFIG}/pack/minpac/opt/minpac > /dev/null
    git pull
    popd > /dev/null
fi

# Install minpack managed components.
vim -E -c PackClean -c q 2> /dev/null
vim -E -c PackUpdate -c q 2> /dev/null 

