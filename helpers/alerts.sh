#!/usr/bin/env bash


# Alert styles
alert_emergency_style="${bold}${reverse}${fg_red}"
alert_error_style="${bold}${fg_red}"
alert_warning_style="${fg_yellow}"
alert_success_style="${fg_green}"
alert_debug_style="${fg_magenta}"
alert_header_style="${fg_cyan}"
alert_input_style="${bold}"
alert_notice_style="${fg_yellow}"
alert_info_style="${fg_lightblue}"


# Base alert function
# param  $1  Type that is prefixing the message
# param  $2  Message to print in the alert
# param  $3  Style to use for the alert
function alert() {
    local _color="${fg_default}"

    # Set color from third argument
    if [[ ! -z ${3} ]]; then
        local _color="${3}"
    fi

    # Stop now if we should be quiet
    if is_quiet; then
        return
    fi

    # Line parts:     Style                  Content                  Reset style
    local _timestamp=("${bg_white}"          "[$(date +"%T")]"        "${reset}")
    local      _type=("${bg_white}${_color}" "$(printf "[%9s]" ${1})" "${reset}")
    local   _message=("${_color} "           "${2}"                   "${reset}")

    # Print the full alert line
    IFS="" # Join arrays with this character
    echo -e "${_timestamp[*]}${_type[*]}${_message[*]}"
}


# Alerts                            Type      Message                        Style                       Extra commands
function alert_die ()       { alert emergency "${@} [Exiting.]"              "${alert_emergency_style}"; safeExit;}
function alert_error ()     { alert error     "${@}"                         "${alert_error_style}"; }
function alert_warning ()   { alert warning   "${@}"                         "${alert_warning_style}"; }
function alert_notice ()    { alert notice    "${@}"                         "${alert_notice_style}"; }
function alert_info ()      { alert info      "${@}"                         "${alert_info_style}"; }
function alert_debug ()     { alert debug     "${@}"                         "${alert_debug_style}"; }
function alert_success ()   { alert success   "${@}"                         "${alert_success_style}"; }
function alert_input()      { alert input     "${@}"                         "${alert_input_style}"; }
function alert_header()     { alert header    "========== ${@} ==========  " "${alert_header_style}"; }


# Alert only if verbose is true
function alert_verbose() {
    if is_verbose; then
        alert_debug "${@}"
    fi
}
