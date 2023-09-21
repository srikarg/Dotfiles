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
brew bundle dump --describe --force --brews --casks --taps --mas --file ~/.Dotfiles/homebrew/.Brewfile
```

### Forcing Local State to Match Homebrew Dump Bundle File

```bash
brew bundle cleanup --force --file ~/.Dotfiles/homebrew/.Brewfile
```

### Upgrading Homebrew Casks

Sourced from <https://stackoverflow.com/a/31994862/1042093>.

#### Normal Upgrade

```bash
brew upgrade --cask
```

#### List Outdated

```bash
brew outdated --cask --greedy --verbose
```

#### Force Upgrade

```bash
brew upgrade --cask --greedy
```
