#!/usr/bin/env bash


# System checks
# ------------------------------------------------------
# Usage:
#    if is_sudo; then
#       ...
#    fi
# ------------------------------------------------------

function is_sudo() {
    if [ "$EUID" -eq 0 ]; then
        return 0
    fi
    return 1
}

function is_not_sudo() {
    if [ "$EUID" -ne 0 ]; then
        return 0
    fi
    return 1
}
