#!/usr/bin/env bash

# Set package manager
if type_exists 'apt-get'; then
    packageManager="apt-get"
elif type_exists 'yum'; then
    packageManager="yum"
else
    alert_die "Can't find supported package manager"
fi


# needSudo
# ------------------------------------------------------
# If a script needs sudo access, call this function which
# requests sudo access and then keeps it alive.
# ------------------------------------------------------
function needSudo () {
    # Update existing sudo time stamp if set, otherwise do nothing.
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

function must_have_sudo () {
    if is_not_sudo; then
        alert_die "This script must be run with sudo."
    fi
}

function must_not_have_sudo () {
    if is_sudo; then
        alert_die "This script must not be run with sudo."
    fi
}

function package_install () {
    if is_empty ${1}; then
        alert_die "Function 'package_install' require package name as first parameter."
    fi
    alert_header "Installing ${1}"
    package_command "install" "${1}"
    alert_success "Done installing ${1}"
}

function package_update () {
    if is_not_empty ${1}; then
        alert_die "Function 'package_update' takes no parameters."
    fi
    package_command "update"
}

function package_command () {
    needSudo
    if [ ${packageManager} = 'apt-get' ]; then
        sudo apt-get -qq -y ${@}
    elif [ ${packageManager} = 'yum' ]; then
        sudo yum ${@}
    fi
}