DIR="${XDG_DATA_HOME:-$HOME/.local/share}/xfce4/terminal/colorschemes"
GRUVBOX_TERM=https://raw.githubusercontent.com/mkarmona/dotfiles/master/.config/xfce4/terminal/colorschemes/gruvbox-dark.theme

echo "Copying .theme files to $dir ..."
mkdir -p "$DIR"

wget -P $DIR $GRUVBOX_TERM
echo "done."
