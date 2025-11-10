#source /Users/isaks/.docker/init-fish.sh || true # Added by Docker Desktop

thefuck --alias | source

set -g fish_autosuggestion_enabled 0

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
#. /usr/share/nvm/init-nvm.sh

# Created by `pipx` on 2025-04-19 08:47:09
set PATH $PATH /home/waldy/.local/bin
set -gx JAVA_HOME /usr/lib/jvm/java-24-jdk

set -gx EDITOR nvim

source /etc/profile.d/fcitx5.sh # Or the path to your script

# set -gx --prepend ASDF_DATA_DIR "/your/custom/data/dir"
# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
