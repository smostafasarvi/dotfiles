# ${ZDOTDIR:-~}/.zshrc


[[ -f .zsh_plugins.txt ]] || touch ${zsh_plugins}.txt
[[ -d .antidote ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
source $HOME/.antidote/antidote.zsh && antidote load

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

sst() {
  # Start ssh-agent if not already running
  if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
  fi

  # Add your key (adjust path if needed)
  if ! ssh-add -l 2>/dev/null | grep -q "metrisa"; then
    ssh-add ~/.ssh/metrisa >/dev/null 2>&1
  fi
  if ! ssh-add -l 2>/dev/null | grep -q "github"; then
    ssh-add ~/.ssh/github >/dev/null 2>&1
  fi
  command ssh "$@"
}
# Force fzf-tab to use the same border/height settings
zstyle ':fzf-tab:*' fzf-flags \
  --color=fg:-1,fg+:1,bg:-1,bg+:-1,hl:4,hl+:3\
  --color=info:6,marker:5,prompt:2,pointer:1\
  --color=header:8,border:7,label:7,query:3\
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="❯ " \
  --marker="❯" --pointer="◆" --separator="─" --scrollbar="│" --info="right"

alias ls="ls -lath --color"
alias nano="nvim"
alias micro="nvim"
alias vim="nvim"
alias vi="nvim"

export PATH="$HOME/.config/emacs/bin:$PATH"

unset HISTFILE
