#!/usr/bin/env bash

# ##################################################
# My Generic BASH script template
#
version="1.0.0"
#
#
#
# ##################################################

# Provide a variable with the location of this script.
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source Scripting Utilities
# -----------------------------------
# These shared utilities provide many functions which are needed to provide
# the functionality in this boilerplate. This script will fail if they can
# not be found.
# -----------------------------------

helperScript="${scriptPath}/shell-helpers.sh" # Update this path to find the utilities.

if [ -f "${helperScript}" ]; then
    source "${helperScript}"
else
    echo "Please find the file shell-helpers.sh and add a reference to it in this script. Exiting."
    exit 1
fi

# trapCleanup Function
# -----------------------------------
# Any actions that should be taken if the script is prematurely
# exited.  Always call this function at the top of your script.
# -----------------------------------
function trapCleanup() {
  echo ""
  # Delete temp files, if any
  if is_dir "${tmpDir}"; then
    rm -r "${tmpDir}"
  fi
  alert_die "Exit trapped."  # Edit this if you like.
}

# safeExit
# -----------------------------------
# Non destructive exit for when script exits naturally.
# Usage: Add this function at the end of every script.
# -----------------------------------
function safeExit() {
  # Delete temp files, if any
  if is_dir "${tmpDir}"; then
    rm -r "${tmpDir}"
  fi
  trap - INT TERM EXIT
  exit
}

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
args=()

# Set Temp Directory
# -----------------------------------
# Create temp directory with three random numbers and the process ID
# in the name.  This directory is removed automatically at exit.
# -----------------------------------
tmpDir="/tmp/${scriptName}.$RANDOM.$RANDOM.$RANDOM.$$"
(umask 077 && mkdir "${tmpDir}") || {
  alert_die "Could not create temporary directory! Exiting."
}

# Logging
# -----------------------------------
# Log is only used when the '-l' flag is set.
#
# To never save a logfile change variable to '/dev/null'
# Save to Desktop use: $HOME/Desktop/${scriptBasename}.log
# Save to standard user log location use: $HOME/Library/Logs/${scriptBasename}.log
# -----------------------------------
logFile="$HOME/.shell-script-logs/${scriptBasename}.log"

# Check for Dependencies
# -----------------------------------
# Arrays containing package dependencies needed to execute this script.
# The script will fail if dependencies are not installed.  For Mac users,
# most dependencies can be installed automatically using the package
# manager 'Homebrew'.  Mac applications will be installed using
# Homebrew Casks. Ruby and gems via RVM.
# -----------------------------------
homebrewDependencies=()
caskDependencies=()
gemDependencies=()

function mainScript() {
############## Begin Script Here ###################
####################################################


# Config file to update
sshConfigFile="$HOME/.ssh/config"

# Header to use and match against in the file
autogeneratedHeader="#################### AUTOGENERATED ####################"


clean_autogenerated_from_file "${sshConfigFile}" "${autogeneratedHeader}"


####################################################
############### End Script Here ####################
}

############## Begin Options and Usage ###################


# Print usage
usage() {
  echo -e -n "
${fg_green}${scriptName}${reset} version ${fg_yellow}${version}${reset}

This is a script template.  Edit this description to print help to users.

${fg_yellow}Usage:${reset}
  command [options] [arguments]

${fg_yellow}Default options:${reset}
    ${fg_green}    --force${reset}       Skip all user interaction.  Implied 'Yes' to all actions.
    ${fg_green}-q, --quiet${reset}       Don't print any output
    ${fg_green}-l, --log${reset}         Print output to logfile
    ${fg_green}-s, --strict${reset}      Exit script with null variables.  i.e 'set -o nounset'
    ${fg_green}-v, --verbose${reset}     Output more information.
    ${fg_green}-d, --debug${reset}       Runs script in BASH debug mode (set -x)
    ${fg_green}-h, --help${reset}        Display this help and exit
    ${fg_green}    --version${reset}     Output version information and exit

${fg_yellow}Options:${reset}
    ${fg_green}    --host${reset}        Host

"
}

# Iterate over options breaking -ab into -a -b when needed and --foo=bar into
# --foo bar
optstring=h
unset options
while (($#)); do
  case $1 in
    # If option is of type -ab
    -[!-]?*)
      # Loop over each character starting with the second
      for ((i=1; i < ${#1}; i++)); do
        c=${1:i:1}

        # Add current char to options
        options+=("-$c")

        # If option takes a required argument, and it's not the last char make
        # the rest of the string its argument
        if [[ $optstring = *"$c:"* && ${1:i+1} ]]; then
          options+=("${1:i+1}")
          break
        fi
      done
      ;;

    # If option is of type --foo=bar
    --?*=*) options+=("${1%%=*}" "${1#*=}") ;;
    # add --endopts for --
    --) options+=(--endopts) ;;
    # Otherwise, nothing special
    *) options+=("$1") ;;
  esac
  shift
done
set -- "${options[@]}"
unset options

# Print help if no arguments were passed.
# Uncomment to force arguments when invoking the script
# [[ $# -eq 0 ]] && set -- "--help"

# Read the options and set stuff
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

    # Script options
    --host) shift; host="${1}" ;;

    # Invalid option
    *) alert_die "invalid option: '$1'." ;;
  esac
  shift
done

# Store the remaining part as arguments.
args+=("$@")

############## End Options and Usage ###################




# ############# ############# #############
# ##       TIME TO RUN THE SCRIPT        ##
# ##                                     ##
# ## You shouldn't need to edit anything ##
# ## beneath this line                   ##
# ##                                     ##
# ############# ############# #############

# Trap bad exits with your cleanup function
trap trapCleanup EXIT INT TERM

# Set IFS to preferred implementation
IFS=$'\n\t'

# Exit on error. Append '||true' when you run the script if you expect an error.
set -o errexit

# Run in debug mode, if set
if ${debug}; then set -x ; fi

# Exit on empty variable
if ${strict}; then set -o nounset ; fi

# Bash will remember & return the highest exitcode in a chain of pipes.
# This way you can catch the error in case mysqldump fails in `mysqldump |gzip`, for example.
set -o pipefail

# Invoke the checkDependenices function to test for Bash packages.  Uncomment if needed.
# checkDependencies

# Run your script
mainScript

safeExit # Exit cleanly