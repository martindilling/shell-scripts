#!/usr/bin/env bash


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

# Set Temp Directory
# -----------------------------------
# Create temp directory with three random numbers and the process ID
# in the name. This directory is removed automatically at exit.
# -----------------------------------
tmpDir="/tmp/${scriptName}.$RANDOM.$RANDOM.$RANDOM.$$"
(umask 077 && mkdir "${tmpDir}") || {
  alert_die "Could not create temporary directory!"
}

# Logging
# -----------------------------------
# Log is only used when the '-l' flag is set.
# -----------------------------------
logFile="${scriptPath}/../logs/${scriptBasename}.log"


# Backup files defined in backups array
# -----------------------------------
function backupFiles () {
    if is_empty "${filesToBackup}"; then
        alert_info "No files to backup"
    else
        if is_backup; then
            alert_header "Forcing backing up files"
        else
            alert_header "Backing up files"
        fi

        for i in "${filesToBackup[@]}"
        do
            file_backup "${backupsDir}" "${i}"
        done
    fi
}

# Restore files defined in backups array
# -----------------------------------
function restoreFiles () {
    if is_empty "${filesToBackup}"; then
        alert_info "No files to restore"
    else
        alert_header "Restoring backed up files"
        for i in "${filesToBackup[@]}"
        do
            file_backup_restore "${backupsDir}" "${i}"
        done
    fi
}


function parseOptions () {
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
}

function executeScript () {
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

    # Backup
    backupFiles

    # Run your script
    mainScript

    safeExit # Exit cleanly
}