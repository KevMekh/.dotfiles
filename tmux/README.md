Paths

```
$HOME/.tmux.conf
or
~/.tmux.conf
```

# Setup

Need to install powerline package from APT for tmux statusline:

```bash
sudo apt install powerline
```

Then symlink tmux config:

```bash
ln -s <absolute_path_to_this_repository>/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

Edit default.json in:

```bash
cd /usr/share/powerline/config_files/themes/tmux/
sudo nvim default.json
```

It should look like this:

```
{
	"segments": {
		"right": [
			{
				"function": "powerline.segments.common.net.hostname"
			}
		]
	}
}
```

# TPM Setup

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
