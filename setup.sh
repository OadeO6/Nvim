#!/usr/bin/env bash

# make sure to run with sudo

dependencies(){
    # python
    # apt install -y python3
    apt install python3.12-venv
    # node
    # npm

    # install rg to be used by telocsocpe
    echo "-- Installing rg......"
    #apt install -y ripgrep

    # install eslint
    npm install -g eslint

}
dependencies
