# upgrade existing packages
sudo apt upgrade &&
sudo apt autoremove &&

# generate ssh key
# ssh-keygen -t rsa -b 4096 -C "vailgrass@gmail.com" &&
# eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa &&

sudo apt install homebrew &&

brew install fzf &&
$(brew --prefix)/opt/fzf/install &&

sudo apt install silversearcher-ag &&

brew install ripgrep &&

git clone git@github.com:hangyu-feng/Setup.git &&
cp ./Setup/.vimrc ~/.vimrc &&

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
vim +PluginInstall +qall &&

sudo apt install zsh && chsh -s $(which zsh) &&

curl -L git.io/antigen > antigen.zsh &&

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&

cp Setup/.zshrc ~/.zshrc && source ~/.zshrc

