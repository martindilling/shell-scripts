#!/usr/bin/env bash


# Backup a file
function file_backup () {
    if is_empty "${1}"; then
        alert_die "Backup path must be given as first parameter to 'file_backup'."
    fi
    if is_not_file "${2}"; then
        alert_error "File '${2}' could not be found. Not backed up."
        return 0
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
            alert_info "Backupfile '$(basename ${newpath})' renamed to '$(basename ${newbackuppath})'."
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
        alert_error "File '${2}' could not be found. Can't restore file that doesn't already exist."
        return 0
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

    realpath="$(cd "$(dirname ${fullpath})";pwd)/$(basename ${fullpath})"

    alert_success "File '${2}' restored from '${realpath}'."
}
