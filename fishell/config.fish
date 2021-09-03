
# Aliases
# Want to wrap this if-statement to incase exa is not installed,
# but it's not working as intended for WSL Ubuntu for some reason.
#if type -q exa
#    alias ls "exa"
#    alias ll "exa -l -g --icons"
#    alias la "ll -a"
#end
# Current solution
alias ls "exa --icons --header"
alias ll "ls -l -g -a --git"
alias la "ls -a"

# Bobthefish theme settings
set -g theme_display_git_default_branch yes
set -g theme_color_scheme zenburn

# Paths
set PATH ~/.cargo/bin $PATH
