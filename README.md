# Dotfiles

My personal dotfiles managed with `GNU Stow`.
You’ll need GNU Stow to manage the symlinks.
Install it with your package manager:

``` shell
sudo pacman -S stow
```

## 🔧 Setup

1.Clone the repo:

```
git clone https://github.com/Umer-Arif/dotfiles.git ~/dotfiles
```

2.Enter the directory:

```
cd ~/dotfiles
```

3.Use GNU Stow to symlink the configs you want:

```
stow niri
stow kitty
stow emacs
stow waybar
stow fuzzel
# etc...

```

This will create symlinks in ~/.config/... pointing to the files here.

## 📂 Structure

Each directory here corresponds to one program. For example:

`kitty/` → `~/.config/niri/`

`mpv/` → `~/.config/mpv/`

`nvim/` → `~/.config/nvim/`
