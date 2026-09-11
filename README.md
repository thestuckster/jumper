Jumper
===

A ZSH plugin, Jumper saves your current path and allows you to quickly jump to others 

[Awesome ZSH plugins](https://github.com/unixorn/awesome-zsh-plugins)

![example](./docs/jumper.gif)


## Installation

1) clone this repository to the plugins folder of your zsh installation. 

if you're using oh-my-zsh it will be `~/.oh-my-zsh/custom/plugins`

2) edit your `.zshrc` file to include `jumper` in the plugins
```
plugins=(jumper)
```

3) close and reopen your terminal window


## Updating

To update to the latest version, pull the latest changes from within the plugin's directory:

```
cd ~/.oh-my-zsh/custom/plugins/jumper
git pull
```

Then close and reopen your terminal window (or run `source ~/.zshrc`) to pick up the changes.


## Usage

Commands and Aliases:

  `jumpAdd [name]`, `ja [name]` : Add current directory to jump list (with optional name)

  `jumpList`, `jl`         : List all saved jump locations

  `jumpRemove <id>`, `jr <id>` : Remove jump location by ID

  `jump <id>`, `j <id>`    : Jump to location with specified ID

  `jumpBack`, `jb`         : Jump back to the previous directory

  `jumpHelp`, `jh`         : Display this help information

Usage Examples:

  `ja [name]`            : Add current directory (with optional name)

  `jl`                   : List all locations

  `jr 2`                 : Remove location with ID 2

  `j 1`                  : Jump to location with ID 1

  `jb`                   : Jump back to the previous directory


Jumper stores all information in the file displayed in the help message. This file can be edited manually as long as the same format is respected.


## Tab Completion

`jump`/`j` and `jumpRemove`/`jr` support tab completion. Pressing `<Tab>` after either command lists the saved IDs/names along with their associated directory, so you can complete without running `jl` first.
