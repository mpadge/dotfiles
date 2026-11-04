# mpadge dotfiles

0n [Archlinux](https://archlinux.org). Lots of things might work or be applicable elsewhere, but many are also arch-specific.

Also includes code for dealing with multiple Git remote locations. Most of my
code is mirrored in many places. This repo, for example, can be found in these
places (in alphabetical order):

- https://bitbucket.org/mpadge/dotfiles/
- https://codeberg.org/mpadge/dotfiles
- https://codefloe.com/mpadge/dotfiles
- https://git.sr.ht/~mpadge/dotfiles
- https://github.com/mpadge/dotfiles
- https://gitlab.com/mpadge/dotfiles
- https://tangled.org/mpadge.tngl.sh/dotfiles

## Uses

- [leftwm](https://leftwm.org) tiling window manager
- [alacritty](https://alacritty.org/) terminal emulator and [tmux](https://github.com/tmux/tmux/wiki)
- [LazyVim](https://lazyvim.org) config for [neovim](https://neovim.org)
- Locally-hosted web searches with [searxng](https://docs.searxng.org/).

## Directories

- `bin` mostly for [pre-commit](https://pre-commit.com/) hooks.
- `etc` currently only for "hosts" file defining local [searxng](https://github.com/searxng/searxng) host.
- `user` also currently only for local [searxng](https://github.com/searxng/searxng) stuff.
- `system` containing a bunch of (mostly) bash scripts called from `.bash_aliases`
