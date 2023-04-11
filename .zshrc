source "$HOME/.zsh/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source "$HOME/.zsh/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"

fpath+=$HOME/.zsh/ohmyzsh/plugins/docker
fpath+=$HOME/.zsh/ohmyzsh/plugins/docker-compose
fpath+=$HOME/.zsh/zsh-users/zsh-completions/src
fpath+=$HOME/.zsh/pure

rm -f ~/.zcompdump
autoload -Uz compinit
compinit

source "$HOME/.zsh/alias-tips/alias-tips.plugin.zsh"

source "$HOME/.zsh/ohmyzsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/copypath/copypath.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/docker-compose/docker-compose.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/git/git.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/gitignore/gitignore.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/history/history.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/history-substring-search/history-substring-search.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/npm/npm.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/macos/macos.plugin.zsh"

ZSH_DOTENV_PROMPT=false
DISABLE_MAGIC_FUNCTIONS=true

autoload -U promptinit
promptinit

PURE_PROMPT_SYMBOL="⚡"

zstyle :prompt:pure:git:stash show yes

prompt pure

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

source "$HOME/.zsh/ohmyzsh/plugins/kubectl/kubectl.plugin.zsh"
source "$HOME/.zsh/ohmyzsh/plugins/minikube/minikube.plugin.zsh"

# History Setup
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks   # Remove superfluous blanks from history items
setopt share_history        # Share history between different instances of the shell
setopt auto_list            # Automatically list choices on ambiguous completion
setopt auto_menu            # Automatically use menu completion
setopt always_to_end        # Move cursor to end if word had one match

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
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

if command -v brew >/dev/null 2>&1; then
  # FZF Auto-completion
  [[ $- == *i* ]] && source "$(brew --prefix fzf)/shell/completion.zsh" 2>/dev/null

  # FZF Key bindings
  source "$(brew --prefix fzf)/shell/key-bindings.zsh"
fi

source "$HOME/.zsh/z/z.sh"
