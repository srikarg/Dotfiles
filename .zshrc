if command -v brew >/dev/null 2>&1; then
  source $(brew --prefix antigen)/share/antigen/antigen.zsh
else
  source /usr/share/zsh-antigen/antigen.zsh
fi

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

autoload -Uz compinit
compinit

antigen bundle colored-man-pages
antigen bundle copydir
antigen bundle copyfile
antigen bundle djui/alias-tips
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle gitignore
antigen bundle history
antigen bundle history-substring-search
antigen bundle kubectl
antigen bundle minikube
antigen bundle npm
antigen bundle osx

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure --branch=main

antigen apply

ZSH_DOTENV_PROMPT=false
DISABLE_MAGIC_FUNCTIONS=true

fpath+=$HOME/.zsh/pure
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
