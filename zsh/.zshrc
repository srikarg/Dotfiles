source "$HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "$HOME/.zsh/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source "$HOME/.zsh/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"

if type brew &>/dev/null
then
  fpath+=$(brew --prefix)/share/zsh/site-functions
fi

fpath+=$HOME/.zsh/ohmyzsh/plugins/docker
fpath+=$HOME/.zsh/ohmyzsh/plugins/docker-compose
fpath+=$HOME/.zsh/ohmyzsh/plugins/helm
fpath+=$HOME/.zsh/ohmyzsh/plugins/volta
fpath+=$HOME/.zsh/zsh-users/zsh-completions/src
fpath+=$HOME/.zsh/pure

autoload -Uz compinit
compinit

source "$HOME/.path"
source "$HOME/.exports"

source "$HOME/.zsh/alias-tips/alias-tips.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/copypath/copypath.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/docker-compose/docker-compose.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/docker/docker.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/helm/helm.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/volta/volta.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/git/git.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/gitignore/gitignore.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/history/history.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/history-substring-search/history-substring-search.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/macos/macos.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/kubectl/kubectl.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/minikube/minikube.plugin.zsh"

DISABLE_MAGIC_FUNCTIONS=true

autoload -U promptinit
promptinit

zstyle :prompt:pure:git:stash show yes

prompt pure

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -s ^f "t\n"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# History Setup
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE
# Source: https://apple.stackexchange.com/questions/427561/macos-zsh-sessions-zsh-history-and-setopt-append-history
SHELL_SESSIONS_DISABLE=1

setopt HIST_IGNORE_ALL_DUPS # Remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from history items
setopt SHARE_HISTORY        # Share history between different instances of the shell
setopt AUTO_LIST            # Automatically list choices on ambiguous completion
setopt AUTO_MENU            # Automatically use menu completion
setopt ALWAYS_TO_END        # Move cursor to end if word had one match
setopt APPEND_HISTORY       # Append history to the history file instead of overwriting
setopt EXTENDED_HISTORY     # Record command execution timestamp and completion time in HISTFILE

autoload bashcompinit
bashcompinit

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &>/dev/null; then
  complete -o default -o nospace -F _git g
fi

# Add tab completion for SSH hostnames based on $HOME/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" "$HOME/.ssh/config" | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall

if command -v brew >/dev/null 2>&1; then
  # FZF Auto-completion
  [[ $- == *i* ]] && source "$(brew --prefix fzf)/shell/completion.zsh" 2>/dev/null

  # FZF Key bindings
  source "$(brew --prefix fzf)/shell/key-bindings.zsh"
fi

eval "$(zoxide init zsh)"
