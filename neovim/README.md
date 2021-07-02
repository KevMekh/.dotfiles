Paths
```
$HOME/.config/nvim/
or
~/.config/nvim/
```

# Setup
```
ln -s <absolute_path_to_git_repo>/.dotfiles/neovim/init.vim ~/.config/nvim/init.vim
```
Plugin manager (vim-plug)
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Use the below command inside Neovim to install plugins:
```
:PlugInstall
```

