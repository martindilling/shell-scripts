#!/usr/bin/env bash


# File checks
# ------------------------------------------------------
# Usage:
#    if is_file "file"; then
#       ...
#    fi
# ------------------------------------------------------

function is_exists() {
    if [[ -e "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_exists() {
    if [[ ! -e "$1" ]]; then
        return 0
    fi
    return 1
}

function is_file() {
    if [[ -f "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_file() {
    if [[ ! -f "$1" ]]; then
        return 0
    fi
    return 1
}

function is_dir() {
    if [[ -d "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_dir() {
    if [[ ! -d "$1" ]]; then
        return 0
    fi
    return 1
}

function is_symlink() {
    if [[ -L "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_symlink() {
    if [[ ! -L "$1" ]]; then
        return 0
    fi
    return 1
}

function is_empty() {
    if [[ -z "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_empty() {
    if [[ -n "$1" ]]; then
        return 0
    fi
    return 1
}