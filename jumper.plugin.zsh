#!/usr/bin/env zsh

JUMPER_FILE="$HOME/.jumper_locations"

# Create the file if it doesn't exist
[[ ! -f "$JUMPER_FILE" ]] && touch "$JUMPER_FILE"

jumpHelp() {
    echo "Jumper Plugin Help"
    echo "==================="
    echo "Configuration file location: $JUMPER_FILE"
    echo ""
    echo "Commands and Aliases:"
    echo "  jumpAdd, ja          : Add current directory to jump list"
    echo "  jumpList, jl         : List all saved jump locations"
    echo "  jumpRemove <id>, jr <id> : Remove jump location by ID"
    echo "  jump <id>, j <id>    : Jump to location with specified ID"
    echo "  jumpHelp, jh         : Display this help information"
    echo ""
    echo "Usage Examples:"
    echo "  ja                   : Add current directory"
    echo "  jl                   : List all locations"
    echo "  jr 2                 : Remove location with ID 2"
    echo "  j 1                  : Jump to location with ID 1"
}

alias jh='jumpHelp'

jumpAdd() {
    local current_dir=$(pwd)
    
    # Check if the current directory already exists in the file
    local existing_entry=$(grep -n ":${current_dir}$" "$JUMPER_FILE")
    if [[ -n "$existing_entry" ]]; then
        local existing_id=$(echo "$existing_entry" | cut -d':' -f1)
        existing_id=$((existing_id - 1))  # Subtract 1 to get the correct ID
        echo "Warning: This path already exists with ID $existing_id"
        return
    fi

    local next_id=$(wc -l < "$JUMPER_FILE" | tr -d ' ')
    echo "${next_id}:${current_dir}" >> "$JUMPER_FILE"
    echo "Added: ${next_id}:${current_dir}"
}

alias ja='jumpAdd'

jumpList() {
    if [[ -s "$JUMPER_FILE" ]]; then
        cat "$JUMPER_FILE"
    else
        echo "No jump locations saved."
    fi
}

alias jl='jumpList'

jumpRemove() {
    if [[ -n "$1" ]]; then
        if grep -q "^$1:" "$JUMPER_FILE"; then
            sed -i.bak "/^$1:/d" "$JUMPER_FILE" && rm "$JUMPER_FILE.bak"
            echo "Removed jump location with ID: $1"
        else
            echo "No jump location found with ID: $1"
        fi
    else
        echo "Please provide an ID to remove."
    fi
}

alias jr='jumpRemove'

jump() {
    if [[ -n "$1" ]]; then
        local jump_path=$(awk -F: '$1=="'"$1"'" {print $2}' "$JUMPER_FILE")
        if [[ -n "$jump_path" ]]; then
            cd "$jump_path"
        else
            echo "No jump location found for ID: $1"
        fi
    else
        echo "Please provide an ID to jump to."
    fi
}

alias j='jump'
