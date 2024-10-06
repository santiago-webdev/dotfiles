# .bash_profile

if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
. "/home/st/.local/share/cargo/env"
