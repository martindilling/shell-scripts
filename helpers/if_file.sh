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
    return $( ! is_exists "$1")
}

function is_file() {
    if [[ -f "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_file() {
    return $( ! is_file "$1")
}

function is_dir() {
    if [[ -d "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_dir() {
    return $( ! is_dir "$1")
}

function is_symlink() {
    if [[ -L "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_symlink() {
    return $( ! is_symlink "$1")
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

function is_write_access() {
    if [[ -w "$1" ]]; then
        return 0
    fi
    return 1
}

function is_not_write_access() {
    return $( ! is_write_access "$1")
}