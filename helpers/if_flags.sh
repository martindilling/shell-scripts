#!/usr/bin/env bash


# Flag checks
# ------------------------------------------------------
# Usage:
#    if is_quiet; then
#       ...
#    fi
# ------------------------------------------------------

function is_quiet() {
    if [[ "${quiet}" = "true" ]] || [ ${quiet} == "1" ]; then
        return 0
    fi
    return 1
}

function is_not_quiet() {
    if [[ "${quiet}" = "false" ]] || [ ${quiet} == "0" ]; then
        return 0
    fi
    return 1
}

function is_verbose() {
    if [[ "${verbose}" = "true" ]] || [ ${verbose} == "1" ]; then
        return 0
    fi
    return 1
}

function is_not_verbose() {
    if [[ "${verbose}" = "false" ]] || [ ${verbose} == "0" ]; then
        return 0
    fi
    return 1
}

function is_force() {
    if [[ "${force}" = "true" ]] || [ ${force} == "1" ]; then
        return 0
    fi
    return 1
}

function is_not_force() {
    if [[ "${force}" = "false" ]] || [ ${force} == "0" ]; then
        return 0
    fi
    return 1
}

function is_strict() {
    if [[ "${strict}" = "true" ]] || [ ${strict} == "1" ]; then
        return 0
    fi
    return 1
}

function is_not_strict() {
    if [[ "${strict}" = "false" ]] || [ ${strict} == "0" ]; then
        return 0
    fi
    return 1
}

function is_debug() {
    if [[ "${debug}" = "true" ]] || [ ${debug} == "1" ]; then
        return 0
    fi
    return 1
}

function is_not_debug() {
    if [[ "${debug}" = "false" ]] || [ ${debug} == "0" ]; then
        return 0
    fi
    return 1
}

function is_backup() {
    if [[ "${backup}" = "true" ]] || [ ${backup} == "1" ]; then
        return 0
    fi
    return 1
}

function is_not_backup() {
    if [[ "${backup}" = "false" ]] || [ ${backup} == "0" ]; then
        return 0
    fi
    return 1
}

function is_restore() {
    if [[ "${restore}" = "true" ]] || [ ${restore} == "1" ]; then
        return 0
    fi
    return 1
}

function is_not_restore() {
    if [[ "${restore}" = "false" ]] || [ ${restore} == "0" ]; then
        return 0
    fi
    return 1
}
