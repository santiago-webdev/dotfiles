# .bash_profile

if [ -f ~/.profile ]; then
    . ~/.profile
fi

# # Get the aliases and functions
# if [ -f ~/.bashrc ]; then
#     . ~/.bashrc
# fi

# User specific environment and startup programs
[[ -d "/home/linuxbrew/" ]] || notify-send "Setting up your shell" 'Running "just brew"' && just brew
[[ -s "$SDKMAN_DIR" ]] || notify-send "Setting up your shell" 'Running "just java"' && just java
[[ -f "$CARGO_HOME/env" ]] || notify-send "Setting up your shell" 'Running "just cargo"' && just caro
