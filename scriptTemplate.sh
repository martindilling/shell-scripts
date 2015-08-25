#!/usr/bin/env bash

# ##################################################
#
__name="Script Template"
__version="1.0.0"
__description="Copy this file and edit it."
__usage="[options] --example-option"
#
# ##################################################

# Provide a variable with the location of this script.
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
args=()

backup=false
restore=false

# Backup necessary files
function backupFiles () {
    alert_backup_header
    alert_info "No files to backup"
#    file_backup "${backupsDir}" "$HOME/some-file"
}

# Restore backup if the --restore option is set
function restoreFiles () {
    if is_restore; then
        alert_restore_header
        alert_info "No files to restore"
#        file_backup_restore "${backupsDir}" "$HOME/some-file"
        safeExit
    fi
}

function mainScript() {
    restoreFiles
    backupFiles
############## Begin Script Here ###################
####################################################



    alert_header "Running script template"
    echo "${example_option}"



####################################################
############### End Script Here ####################
}

############## Begin Options and Usage ###################


# Print usage
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
  ${fg_green}    --example-option${reset}   Host

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

    # Backup options
    --backup) backup=true ;;
    --restore) restore=true ;;

    # Script options
    --example-option) shift; example_option="${1}" ;;

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