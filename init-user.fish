pushd ~/
mkdir code
# make sure user is installed
sh ./.dotfiles/apply-user.sh
# doom emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install --no-env --no-config
fish_add_path ~/.emacs.d/bin
popd
