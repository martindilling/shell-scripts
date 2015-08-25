#!/usr/bin/env bash


function alert_backup_header () {
    if is_backup; then
        alert_header "Forcing backing up files"
    else
        alert_header "Backing up files"
    fi
}

function alert_restore_header () {
    if is_restore; then
        alert_header "Restoring backed up files"
    fi
}


# Backup a file
function file_backup () {
    if is_empty "${1}"; then
        alert_die "Backup path must be given as first parameter to 'file_backup'."
    fi
    if is_not_file "${2}"; then
        alert_die "File given as second parameter to 'file_backup' must exists and be a file."
    fi

    newpath="${1}${2}"

    if is_not_dir $(dirname "${newpath}"); then
        mkdir -p $(dirname "${newpath}")
    fi

    if ! is_backup; then
        if is_file "${newpath}"; then
            alert_info "File '${2}' is already backed up."
            return 0
        fi
    else
        if is_file "${newpath}"; then
            newbackuppath="$(dirname ${newpath})/${timestamp}_$(basename ${newpath})"
            mv ${newpath} ${newbackuppath}
        fi
    fi

    cat "${2}" > "${newpath}"
    alert_success "File '${2}' backed up."
}

# Restore a backed up file
function file_backup_restore () {
    if is_empty "${1}"; then
        alert_die "Backup path must be given as first parameter to 'file_backup'."
    fi
    if is_not_file "${2}"; then
        alert_die "File given as second parameter to 'file_backup' must exists and be a file."
    fi

    fullpath="${1}${2}"

    if is_not_file "${fullpath}"; then
        alert_info "No backup exists."
        return 0
    fi


    if is_write_access "${2}"; then
        cat "${fullpath}" > "${2}"
    else
        needSudo
        sudo bash -c "cat \"${fullpath}\" > \"${2}\""
    fi

    alert_success "File '${2}' restored from '${fullpath}'."
}
