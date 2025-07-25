Jumper
===

A ZSH plugin, Jumper saves your current path and allows you to quickly jump to others 

## Installation

1) clone this repository to the plugins folder of your zsh installation. 

if you're using oh-my-zsh it will be `~/.oh-my-zsh/custom/plugins`

2) edit your `.zshrc` file to include `jumper` in the plugins
```
plugins=(jumper)
```

3) close and reopen your terminal window


## Usage

Commands and Aliases:

  jumpAdd [name], ja [name] : Add current directory to jump list (with optional name)

  jumpList, jl         : List all saved jump locations

  jumpRemove <id>, jr <id> : Remove jump location by ID

  jump <id>, j <id>    : Jump to location with specified ID

  jumpBack, jb         : Jump back to the previous directory

  jumpHelp, jh         : Display this help information

Usage Examples:

  ja [name]            : Add current directory (with optional name)

  jl                   : List all locations

  jr 2                 : Remove location with ID 2

  j 1                  : Jump to location with ID 1

  jb                   : Jump back to the previous directory


Jumper stores all information in the file displayed in the help message. This file can be edited manually as long as the same format is respected.
