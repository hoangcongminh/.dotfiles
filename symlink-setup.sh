rm -rf $HOME/.config/nvim
rm -rf $HOME/.config/alacritty
rm -rf $HOME/.config/karabiner
rm -rf $HOME/.config/kitty
rm -rf $HOME/.config/fish
rm -rf $HOME/.config/yabai
rm -rf $HOME/.config/skhd

ln -sfn $HOME/.dotfiles/config/nvim $HOME/.config/nvim
ln -sfn $HOME/.dotfiles/config/alacritty $HOME/.config/alacritty
ln -sfn $HOME/.dotfiles/config/karabiner $HOME/.config/karabiner
ln -sfn $HOME/.dotfiles/config/kitty $HOME/.config/kitty
ln -sfn $HOME/.dotfiles/config/fish $HOME/.config/fish
ln -sfn $HOME/.dotfiles/config/yabai $HOME/.config/yabai
ln -sfn $HOME/.dotfiles/config/skhd $HOME/.config/skhd

ln -sfn $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
ln -sfn $HOME/.dotfiles/zsh/.zshenv $HOME/.zshenv
ln -sfn $HOME/.dotfiles/zsh/.p10k.zsh $HOME/.p10k.zsh
ln -sfn $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -sfn $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
ln -sfn $HOME/.dotfiles/.vimrc $HOME/.vimrc

echo "Done symlink setup."
