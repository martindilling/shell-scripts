#!/usr/bin/env bash

###############################################################################
#
__name="Script Template"
__version="1.0.0"
__description="Copy this file and edit it."
__usage="[options] -e|--example-option --another-option"
#
###############################################################################

# Path of this script
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Include helper scripts
helperScript="${scriptPath}/shell-helpers.sh"
if [ -f "${helperScript}" ]; then
    source "${helperScript}"
else
    echo "Please find the file shell-helpers.sh and add a reference to it in this script. Exiting."
    exit 1
fi


# Set Flags
# -----------------------------------
# Flags which can be overridden by user input.
# Default values are below
# -----------------------------------
quiet=false
printLog=false
verbose=false
force=false
strict=false
debug=false
backup=false
args=()


# Backup
# -----------------------------------
# List of files handled by the backup and restore functionality.
# Files will always be backed up the first time the script is
# executed, after that you need to manually add --backup to
# backup the current state of the files.
# -----------------------------------
filesToBackup=(
    "$HOME/.zshrc"
)


function mainScript() {
  # ## ### ################################# ### ## #
 # ## ### ####        BEGIN SCRIPT       #### ### ## #
# ## ### ##################################### ### ## #



    alert_header "Running script template"
    alert_info "${example_option}"
    alert_info "${another_example}"



# ## ### ##################################### ### ## #
 # ## ### ####         END SCRIPT        #### ### ## #
  # ## ### ################################# ### ## #
}


# Usage
# -----------------------------------
# Information about how to use the script
# -----------------------------------
usage() {
  echo -e -n "
${fg_green}${__name}${reset} version ${fg_yellow}${__version}${reset}

${__description}

${fg_yellow}Usage:${reset}
  ${scriptBasename} ${__usage}

${fg_yellow}Default options:${reset}
  ${fg_green}    --force${reset}       Skip all user interaction.  Implied 'Yes' to all actions.
  ${fg_green}-q, --quiet${reset}       Don't print any output
  ${fg_green}-l, --log${reset}         Print output to logfile
  ${fg_green}-s, --strict${reset}      Exit script with null variables.  i.e 'set -o nounset'
  ${fg_green}-v, --verbose${reset}     Output more information.
  ${fg_green}-d, --debug${reset}       Runs script in BASH debug mode (set -x)
  ${fg_green}-h, --help${reset}        Display this help and exit
  ${fg_green}    --version${reset}     Output version information and exit

${fg_yellow}Backup options:${reset}
  ${fg_green}    --backup${reset}      Backup and overwrite previous backup (Auto backup on first run)
  ${fg_green}    --restore${reset}     Restore backup (Doesn't run script only restores)

${fg_yellow}Options:${reset}
  ${fg_green}-e, --example-option${reset}   Example option with shortcut
  ${fg_green}    --another-example${reset}  Another example option

"
}


# Iterate over options breaking `-ab` into `-a -b` when needed and `--foo=bar` into  `--foo bar`
parseOptions


# Print help if no arguments were passed.
# -----------------------------------
# Uncomment to force arguments when invoking the script
# -----------------------------------
# [[ $# -eq 0 ]] && set -- "--help"


# Options
# -----------------------------------
# How are we handling the options given
# -----------------------------------
while [[ $1 = -?* ]]; do
  case $1 in
    # Default options
    --force) force=true ;;
    -q|--quiet) quiet=true ;;
    -l|--log) printLog=true ;;
    -s|--strict) strict=true;;
    -v|--verbose) verbose=true ;;
    -d|--debug) debug=true;;
    -h|--help) usage >&2; safeExit ;;
    --version) echo "$(basename $0) ${version}"; safeExit ;;
    --endopts) shift; break ;;

    # Backup options
    --backup) backup=true ;;
    --restore) restoreFiles; safeExit ;;

    # Script options
    -e|--example-option) shift; example_option="${1}" ;;
    --another-example) shift; another_example="${1}" ;;

    # Invalid option
    *) alert_die "invalid option: '$1'." ;;
  esac
  shift
done


# Store the remaining part as arguments.
args+=("$@")



# ## ### ##################################### ### ## #
 # ## ### ####    EXECUTE THE SCRIPT     #### ### ## #
# ## ### ##################################### ### ## #

executeScript
