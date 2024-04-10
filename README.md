# tmux-sessionizer
A simple script to fuzzy find your project and start tmux session with preconfigured windows layout.

Inspired and based on [ThePrimeagen's](https://github.com/ThePrimeagen) dotfile.

## Prerequisites
- [fzf](https://github.com/junegunn/fzf)
- [tmux](https://github.com/tmux/tmux)
- [teamocil](https://github.com/remi/teamocil)
## Installation
```bash
git clone git@github.com:laporchen/tmux-sessionizer.git
cd tmux-sessionizer
chmod +x sessionizer
ln -s $(pwd)/sessionizer ~/.local/bin/sessionizer
```

## Configuration
### Project paths
Edit the `sessionizer` script and change the `search_paths` variable to your project directories.

### Project window configurations
This script uses [teamocil](https://github.com/remi/teamocil) to handle the layout configuration.
You can create a configuration file for each project in where you store your `teamocil` layout files.
The configuration file should be named after the project directory name with `.yml` extension.

## Usage
```bash
sessionizer
```
