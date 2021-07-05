# .dotfiles
My .dotfiles configs (Considering converting to bare repository, need to read more about it)

Run the below command replacing the text including <>
```
ln -s <absolute_path_to_current_file> <absolute_path_to_config_file>
```
Each folder includes README.md-files specifying the paths in my linux system. Eg. with Neovim:
```
ln -s ~/.dotfiles/neovim/init.vim ~/.config/nvim/init.vim
```
README.md-files in each folder also explains how to setup the configs if there are any extra steps.

My settings also require powerline patched fonts. 
Currently using the [Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack) font.

CLI Tools installed with [cargo](https://github.com/rust-lang/cargo):
* bat 
* exa
* ripgrep
