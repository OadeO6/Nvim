#!/usr/bin/env bash

# make sure to run with sudo

dependencies(){
    # python
    if ( which python 1>/dev/null || which python3 1> /dev/null)
    then
	    echo "python installed"
    else
	    echo "-- Installing python......"
	    apt install -y python3
    fi

    #apt install -y python3.12-venv
    # node

    # python
    if ( which node 1>/dev/null)
    then
	    echo "node installed"
    else
	    echo "-- Installing node......"
	    apt install -y nodejs
    fi
    # npm
    # python
    if ( which npm 1>/dev/null)
    then
	    echo "npm installed"
    else
	    echo "-- Installing npm....."
	    apt install -y npm
    fi

    # install nvim
    if ( which nvim 1> /dev/null )
    then
	    echo "Nvim available"
    else
	    echo "-- Installing nvim......"
	    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
	    tar xzf nvim-linux64.tar.gz
	    sudo mv nvim-linux64 /usr/local/nvim
	    sudo ln -s /usr/local/nvim/bin/nvim /usr/bin/nvim
    fi

    # install rg to be used by telocsocpe
    if ( which rg 1>/dev/null)
    then
	    echo "rg installed"
    else
	    echo "-- Installing rg......"
	    apt install -y ripgrep
    fi

    # install eslint
    #npm install -g eslint
}
dependencies
