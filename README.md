# Graeme's Dotfiles

Here are your dotfiles

## What this gets you:

- A bare minimum Vim config that has: an extension manager (Vundle.vim) and
  some sensible defaults and plugins
- A git config that provides some reasonable defaults, a global ignore, and the
  commit hook we use for gerrit
- A bundler config that installs gems into `vendor/bundle` (inside the project)
  when you run `bundle install` so you have them easily accessible during
  development
- Oh-My-Zsh and a reasonable .zshrc

## Installation

#### Install the following, if you haven't already:
```sh
stow


# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


# jhawthorn/fzy
git clone git@github.com:jhawthorn/fzy.git
cd fzy
make
sudo make install


# chruby
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install


# ripgrep - requires Rust (https://www.rust-lang.org/en-US/)
git clone https://github.com/BurntSushi/ripgrep
cd ripgrep
cargo build --release
./target/release/rg --version


# redis


# postgres 9.6


# yarn
sudo apt install yarn

# node


# Direnv
sudo apt-get install direnv
```

#### Basic Installation
```sh
git clone https://github.com/gevann/dotfiles.git
cd dotfiles
git submodule init
git submodule update
stow --v bundler git vim zsh i3 -t ~
```
