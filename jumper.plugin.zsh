#!/usr/bin/env zsh

JUMPER_FILE="$HOME/.jumper_locations"
JUMPER_BACK_FILE="$HOME/.jumper_back"

# Create the file if it doesn't exist
[[ ! -f "$JUMPER_FILE" ]] && touch "$JUMPER_FILE"
[[ ! -f "$JUMPER_BACK_FILE" ]] && touch "$JUMPER_BACK_FILE"

jumpHelp() {
    echo "Jumper Plugin Help"
    echo "==================="
    echo "Configuration file location: $JUMPER_FILE"
    echo ""
    echo "Commands and Aliases:"
    echo "  jumpAdd [name], ja [name] : Add current directory to jump list (with optional name)"
    echo "  jumpList, jl         : List all saved jump locations"
    echo "  jumpRemove <id>, jr <id> : Remove jump location by ID"
    echo "  jump <id>, j <id>    : Jump to location with specified ID"
    echo "  jumpBack, jb         : Jump back to the previous directory"
    echo "  jumpHelp, jh         : Display this help information"
    echo ""
    echo "Usage Examples:"
    echo "  ja [name]            : Add current directory (with optional name)"
    echo "  jl                   : List all locations"
    echo "  jr 2                 : Remove location with ID 2"
    echo "  j 1                  : Jump to location with ID 1"
    echo "  jb                   : Jump back to the previous directory"
}

alias jh='jumpHelp'

jumpAdd() {
    local current_dir=$(pwd)
    local name=""
    
    # If first argument is provided, use it as the name
    if [[ -n "$1" ]]; then
        name="$1"
    fi
    
    # Check if the current directory already exists in the file
    local existing_entry=$(grep -n ":${current_dir}$" "$JUMPER_FILE")
    if [[ -n "$existing_entry" ]]; then
        local existing_id=$(echo "$existing_entry" | cut -d':' -f1)
        existing_id=$((existing_id - 1))  # Subtract 1 to get the correct ID
        echo "Warning: This path already exists with ID $existing_id"
        return
    fi

    local next_id=$(wc -l < "$JUMPER_FILE" | tr -d ' ')
    if [[ -n "$name" ]]; then
        echo "${name}:${current_dir}" >> "$JUMPER_FILE"
        echo "Added: ${name}:${current_dir}"
    else
        echo "${next_id}:${current_dir}" >> "$JUMPER_FILE"
        echo "Added: ${next_id}:${current_dir}"
    fi
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
        # Store current directory in the back file before jumping
        pwd > "$JUMPER_BACK_FILE"
        
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

jumpBack() {
    if [[ -s "$JUMPER_BACK_FILE" ]]; then
        local back_dir=$(<"$JUMPER_BACK_FILE")
        pwd > "$JUMPER_BACK_FILE"
        if [[ -d "$back_dir" ]]; then
            cd "$back_dir"
        fi
    fi
}

alias jb='jumpBack'
