# Srikar's Dotfiles

## Installation

1. Clone this repository into `~/.Dotfiles`
2. Install [pure](https://github.com/sindresorhus/pure) ZSH prompt with
   `npm install -g pure-prompt`
3. `cd` into the Dotfiles directory
4. Run `./setup.sh` located in the directory

## Common Tasks

### Update Git Submodules

```bash
git submodule update --recursive --remote
```

### Updating Homebrew Dump Bundle File

```bash
brew bundle dump --describe --force --file ~/.Dotfiles/.Brewfile
```

### Forcing Local State to Match Homebrew Dump Bundle File

```bash
brew bundle cleanup --force --file ~/.Dotfiles/.Brewfile
```
