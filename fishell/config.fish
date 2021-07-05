
# Aliases
# Want to wrap this if-statement to incase exa is not installed,
# but it's not working as intended for WSL Ubuntu for some reason.
#if type -q exa
#    alias ls "exa"
#    alias ll "exa -l -g --icons"
#    alias la "ll -a"
#end
# Current solution
alias ls "exa --icons"
alias ll "exa -l -g -a --icons --git"
alias la "ls -a"

# Paths
set PATH ~/.cargo/bin $PATH
