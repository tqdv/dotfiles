# dotfiles

My configuration files and some scripts.

## Usage

Add the `DOTFILES` variable to your `.bashrc`, then source various files in `Scripts/`

The file format is currently inconsistent, maybe a table will help...

## Useful things

git-commitas: A script to manage multiple users on the same machine

## vimrc

This is the file I edit the most (for some reason).

TL;DR :
```vim
" pkg : vim
" help :
"   - :help options
"   - :options
" filename : ~/.vim/vimrc
" notes :
"   - viminfo location is ~/.vim/viminfo
"   - noexpandtab
"   - :Nu[mbers]
"   - :L[ist]
"   - Q :noh[lsearch]
"   - ~~ switch character case
"   - ~` switch line case
"   - <C-(H|J|K|L)> <C-W>(h|j|k|l)
"   - i_jkj <Esc>
"   - v_<Space><Space> <Esc>
"   - v_* and v_# work like Normal mode
```

Ressources :
  - [Search in Visual Mode][search_visual]
  - [amix/vimrc][amix_vimrc] (I don't really like it, but it's useful as a reference)
  - [thoughtbot/dotfiles][thoughtbot_dotfiles] (Initial inspiration for my vimrc)

### vimrc-min

As sometimes I don't have access to my usual vimrc, this is an attempt at
a smaller version (~50 lines) to remember.

[search_visual]: http://vim.wikia.com/wiki/Search_for_visually_selected_text
[amix_vimrc]: https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
[thoughtbot_dotfiles]: https://github.com/thoughtbot/dotfiles/blob/master/vimrc
