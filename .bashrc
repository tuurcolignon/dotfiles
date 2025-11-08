#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

neofetch

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias way='pkill waybar && waybar &'
PS1='\u@\[\e[35m\]\h\e[0m \w >> '
#PS1='\[\e[41m\] \[\e[42m\] \[\e[43m\] \[\e[44m\] \[\e[0m\] \u@\h:\w\$ '

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias strava='cd NextJsProjects/stravawars-next.js; npm run dev'
alias checkupdates='checkupdates | tee /tmp/neofetch_updates_cache'


export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize



# Created by `pipx` on 2025-08-23 23:02:32
export PATH="$PATH:/home/tuur/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"
#export PATH="$HOME/anaconda3/bin:$PATH"
export EDITOR=nano

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tuur/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tuur/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tuur/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tuur/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

