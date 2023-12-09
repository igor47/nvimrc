# nvimrc

config for neovim.
this dir is meant to be symlinked to `~/.config/nvim`:

```sh
$ ln -s ~/repos/nvimrc ~/.config/nvim
```

## Manual setup

To install plugins:

```
:PackerInstall
```

To use mypy with pylsp it has to be installed manually:

```
:PylspInstall pylsp-mypy
```
