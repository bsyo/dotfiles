# Fish configuration equivalent to the provided Zsh config
# Save this to ~/.config/fish/config.fish

starship init fish | source
# Homebrew setup for macOS
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# Key bindings
bind \cp history-search-backward
bind \cn history-search-forward
bind \ew kill-word

# History settings
set -g HISTSIZE 5000
set -g fish_history_file ~/.local/share/fish/fish_history
set -g SAVEHIST $HISTSIZE

# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin
set -gx BAT_THEME tokyonight_night

# Additional PATH entries
fish_add_path "$HOME/.rbenv/bin"
fish_add_path /usr/local/sbin
fish_add_path "$HOME/.local/bin"
fish_add_path /opt/homebrew/bin

# FZF configuration
set -gx FZF_DEFAULT_COMMAND "fd --hidden --strip-cwd-prefix --exclude .git"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND "fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF color theme
set -l fg "#CBE0F0"
set -l bg "#011628"
set -l bg_highlight "#143652"
set -l purple "#B388FF"
set -l blue "#06BCE4"
set -l cyan "#2CF9ED"

set -gx FZF_DEFAULT_OPTS "--color=fg:$fg,bg:$bg,hl:$purple,fg+:$fg,bg+:$bg_highlight,hl+:$purple,info:$blue,prompt:$cyan,pointer:$cyan,marker:$cyan,spinner:$cyan,header:$cyan"

# Eza (better ls) aliases
set -l eza_params --git --icons --group --group-directories-first --time-style=long-iso --color-scale=all

alias ls "eza $eza_params"
alias l "eza --git-ignore $eza_params"
alias ll "eza --all --header --long $eza_params"
alias llm "eza --all --header --long --sort=modified $eza_params"
alias la "eza -lbhHigUmuSa"
alias lx "eza -lbhHigUmuSa@"
alias lt "eza --tree $eza_params --level=5"
alias tree "eza --tree $eza_params --level=5"

# Other aliases
alias vim nvim
alias c clear
alias cd z
alias awsp 'set -gx AWS_PROFILE (aws configure list-profiles | fzf)'

# Initialize zoxide (better cd)
zoxide init fish | source

# Initialize rbenv
status --is-interactive; and rbenv init - fish | source

# Load direnv
direnv hook fish | source

# Source local environment variables if they exist
if test -f ~/.env
    source ~/.env
end

# Function to show file or directory preview (for FZF)
function show_file_or_dir_preview
    if test -d "$argv"
        eza --tree --color=always "$argv" | head -200
    else
        bat -n --color=always --line-range :500 "$argv"
    end
end

# FZF preview options
set -gx FZF_CTRL_T_OPTS "--preview 'show_file_or_dir_preview {}'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

# Note: Some Zsh plugins don't have direct Fish equivalents.
# You might want to install Fisher (plugin manager for Fish) and look for similar plugins:
# curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
# Then you can install plugins like:
# fisher install jethrokuan/fzf
# fisher install PatrickF1/fzf.fish
# fisher install meaningful-ooo/sponge
# fisher install IlanCosman/tide@v5 # Alternative to powerlevel10k

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/yu/.lmstudio/bin
# End of LM Studio CLI section

