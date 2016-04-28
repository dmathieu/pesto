# Pesto
[![Build Status](https://travis-ci.org/dmathieu/pesto.svg?branch=master)](https://travis-ci.org/dmathieu/pesto)
A simple CLI pomodoro app meant to be used with tmux

## Tmux configuration

My local config includes a symlink to the `pesto` binary in my $PATH.
Then, I have the following in my tmux configuration

```
set -g status-left "#[fg=green]#(zsh -c pesto)"

bind-key p run-shell 'pesto --start'
bind-key x run-shell 'pesto --stop'
```
