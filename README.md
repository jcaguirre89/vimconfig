# VIM Configuration
my `.vimrc` and `.vim` folder with packages as submodules.
# Usage

```bash
git clone --recursive git@github.com:jcaguirre89/vimconfig.git
# Create symlinks so vim can find config files and packages
ln -sf vimconfig/.vim ~/.vim
ln -sf vimconfig/vimrc ~/.vimrc
```

## vim-flake8 and ALE
Must install pylint:
```bash
sudo apt install pylint
```

## YouCompleteMe
[Instructions here](https://github.com/Valloric/YouCompleteMe#linux-64-bit)

## Tagbar
Install ctags: `sudo apt install ctags`

I mapped `<F11>` to the create tags command (`ctags -R .`) for virtual environments, and `<leader>b` to see the TagBar.

## Ag - Silver searcher
Must install silver searcher: `sudo apt-get install silversearcher-ag`. Mappings:
- `<leader>vc`: Open text search for part of a word
- `<leader>vp`: Open text search for the entire word and nothing else
- `<leader>vv`: Search word under cursor (works in normal or visual mode for more than 1 word)
