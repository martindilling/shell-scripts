#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


source "$DIR/../helpers/variables.sh"
source "$DIR/../helpers/colours.sh"
source "$DIR/../helpers/alerts.sh"
source "$DIR/../helpers/if_system.sh"
source "$DIR/../helpers/if_flags.sh"
source "$DIR/../helpers/if_file.sh"
source "$DIR/../helpers/if_type.sh"
source "$DIR/../helpers/shell_script_functions.sh"
source "$DIR/../helpers/system_functions.sh"
source "$DIR/../helpers/ask_functions.sh"
source "$DIR/../helpers/file_functions.sh"
source "$DIR/../helpers/backup_functions.sh"