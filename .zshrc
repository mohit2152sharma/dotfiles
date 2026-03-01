# zmodload zsh/zprof # for profiling
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
ZSH_LAZY_LOAD="true"

autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-autocomplete fast-syntax-highlighting)
# plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete tmux)
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)
# export ZSH_TMUX_AUTOSTART=true
# export ZSH_TMUX_DEFAULT_SESSION_NAME=main
# export ZSH_TMUX_AUTONAME_SESSION=true
# export ZSH_TMUX_AUTOCONNECT=true
# export ZSH_TMUX_CONFIG="${HOME}/.config/tmux/tmux.conf"
source "$ZSH"/oh-my-zsh.sh

# Removed conda as using uv and conda slows the startup
# __conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "$HOME/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="$HOME/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# # ---- functions ----
file_dir=$HOME/github/dotfiles
source "$file_dir"/zsh-funcs/f0.zsh
source "$file_dir"/zsh-funcs/todo-strings.zsh
source "$file_dir"/zsh-funcs/svelte-route.bash
# source $file_dir/zsh-funcs/saral.bash
source ~/github/dev-journal/create_rewiser_doc.sh

# ---- aliases -----
alias ..="cd .."
alias gcb="git checkout -b"
alias gcd="git checkout develop"
alias gcm="git checkout master"
alias rv="create_rewiser_file"
# alias vim=nvim
# alias vi=nvim
alias myiss="jira issue list -q \"sprint in openSprints() and (status='In Progress' or status='To Do')\" --plain"
alias aocinput="$HOME/github/programming-problems/utils/download-aoc-file.bash"
alias cpd="create_planning_doc"
alias tf="terraform"
alias lsd="ls -1d */"
alias lsad="ls -l | grep ^d"
alias src="source ~/.zshrc"
alias bum="bun"
alias pv="source .venv/bin/activate"
alias pd="deactivate"
alias gettodo="todo_alias"
alias nrd="npm run dev"
alias svr="create_route"
alias cpr="create_pr"
alias mpr="gh pr merge -s"
alias lg="lazygit"
alias rswf="remove_swap_files"
alias k="kubectl"
alias kpo="kubectl get pods"

# ---- environment vars ----
source ~/.openai
source ~/.jira
source ~/.elevenlabs
source ~/.github
source ~/.config/smtp/.smtp
source ~/.config/planetscale/.planetscale
export MY_ENV=test
export MY_REGION=ap-south-1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export KAGGLE_CONFIG_DIR="$HOME/.config/.kaggle"
export PYTHONPATH="${PYTHONPATH}":$(pwd)
export GOPATH=$(go env GOPATH)
export GOOGLE_APPLICATION_CREDENTIALS="~/.config/gcloud/application_default_credentials.json"
load_dot_files ~/.e2e/config
load_dot_files ~/.hetzner/config
load_dot_files ~/.digitalocean/config
load_dot_files ~/.config/longpost/config
load_dot_files ~/.config/aws/config
load_dot_files ~/.awsrds
load_dot_files ~/.config/dodo-payments/config
# The azure config were created using command:
# az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/{subscriptionId}"
# These configurations are used for terraform
load_dot_files ~/.config/azure/.config
export TF_VAR_DO_TOKEN=$DO_TOKEN
export TF_VAR_hcloud_token=$HETZNER_TOKEN
# export KUBECONFIG=$HOME/github/bsky-projects/longpost/infra/digital-ocean/kubeconfig.yaml
export KUBECONFIG=$HOME/github/bsky-projects/longpost/infra/hetzner/k3s_kubeconfig.yaml


# ---- cli tools ----
# Already doing at the top
# autoload -U compinit && compinit

source <(fzf --zsh)

eval "$(zoxide init zsh)"


eval "$(register-python-argcomplete pipx)"
# Created by `pipx` on 2024-10-30 19:38:48
export PATH="$PATH:$HOME/.local/bin"

complete -o nospace -C /opt/homebrew/bin/terraform terraform

. "$HOME"/.cargo/env

export PATH="$PATH:$GOPATH/bin"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# postgresql path
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@17/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@17/include"

# To start postgresql@17 now and restart at login:
#   brew services start postgresql@17
# Or, if you don't want/need a background service you can just run:
#   LC_ALL="C" /opt/homebrew/opt/postgresql@17/bin/postgres -D /opt/homebrew/var/postgresql@17

# This variable to tackle the navigating issue between nvim and wezterm
[ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"
#
# zprof # for profiling

# Added by GitButler installer
eval "$(but completions zsh)"
