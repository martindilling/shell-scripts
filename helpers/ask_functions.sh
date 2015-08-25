#!/usr/bin/env bash


# SEEKING CONFIRMATION
# ------------------------------------------------------
# Asks questions of a user and then does something with the answer.
# y/n are the only possible answers.
#
# USAGE:
# seek_confirmation "Ask a question"
# if is_confirmed; then
#     some action
# else
#     some other action
# fi
#
# Credt: https://github.com/natelandau/shell-scripts/blob/master/lib/sharedFunctions.sh#L234
# ------------------------------------------------------

# Ask the question
function seek_confirmation() {
    alert_input "${@}"
    if is_force; then
        alert_notice "Forcing confirmation with '--force' flag set"
    else
        echo -n "(y/n):"
        read REPLY
        if [[ ! "${REPLY}" =~ ^[YyNn]$ ]]; then
            alert_warning "'${REPLY}' is not an accepted answer."
            seek_confirmation "${@}"
        fi
    fi
}

# Did the user confirm
function is_confirmed() {
    if is_force; then
        return 0
    else
        if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
            return 0
        fi
        return 1
    fi
}

# Did the user decline
function is_not_confirmed() {
    if is_force; then
        return 1
    else
        if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
            return 0
        fi
        return 1
    fi
}