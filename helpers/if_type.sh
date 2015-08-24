#!/usr/bin/env bash


# Type checks
# ------------------------------------------------------
# Usage:
#    if type_exists 'git'; then
#      some action
#    else
#      some other action
#    fi
# ------------------------------------------------------

function type_exists() {
    if [ $(type -t "$1") ]; then
        return 0
    fi
    return 1
}

function type_not_exists() {
    if [ ! $(type -t "$1") ]; then
        return 0
    fi
    return 1
}

function type_is_alias() {
    if [[ "$(type -t "$1")" = "alias" ]]; then
        return 0
    fi
    return 1
}

function type_is_not_alias() {
    if [[ ! "$(type -t "$1")" = "alias" ]]; then
        return 0
    fi
    return 1
}

function type_is_keyword() {
    if [[ "$(type -t "$1")" = "keyword" ]]; then
        return 0
    fi
    return 1
}

function type_is_not_keyword() {
    if [[ ! "$(type -t "$1")" = "keyword" ]]; then
        return 0
    fi
    return 1
}

function type_is_function() {
    if [[ "$(type -t "$1")" = "function" ]]; then
        return 0
    fi
    return 1
}

function type_is_not_function() {
    if [[ ! "$(type -t "$1")" = "function" ]]; then
        return 0
    fi
    return 1
}

function type_is_builtin() {
    if [[ "$(type -t "$1")" = "builtin" ]]; then
        return 0
    fi
    return 1
}

function type_is_not_builtin() {
    if [[ ! "$(type -t "$1")" = "builtin" ]]; then
        return 0
    fi
    return 1
}

function type_is_file() {
    if [[ "$(type -t "$1")" = "file" ]]; then
        return 0
    fi
    return 1
}

function type_is_not_file() {
    if [[ ! "$(type -t "$1")" = "file" ]]; then
        return 0
    fi
    return 1
}
