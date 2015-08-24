#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


source "$DIR/variables.sh"
source "$DIR/colours.sh"
source "$DIR/alerts.sh"
source "$DIR/if_system.sh"
source "$DIR/if_flags.sh"
source "$DIR/if_file.sh"
source "$DIR/if_type.sh"
source "$DIR/system_functions.sh"
source "$DIR/ask_functions.sh"