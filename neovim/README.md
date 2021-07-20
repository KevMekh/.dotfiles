Paths
```
$HOME/.config/nvim/
or
~/.config/nvim/
```

# Setup
Install plugin manager (vim-plug)
```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Then symlink:
```
ln -s <absolute_path_to_git_repo>/.dotfiles/neovim/init.vim ~/.config/nvim/init.vim
```
Use the below command inside Neovim to install plugins:
```
:PlugInstall
```
For WSL to use global clipboard, install win32yank:
```
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
```
