source $DOTFILES_TOOL_PATH/common.sh

REPO=https://github.com/junegunn/fzf.git
TARGET=/usr/local/bin/fzf
MD=$DOTFILES_CURRENT_MOD_DIR

ubuntu_install() {
    # This is intentionally left installed
    sudo apt-get -y install zsh
    sudo chsh -s /bin/zsh
}

_install() {
    has_platform ubuntu18 && ubuntu_install
    ln -s "$MD" "$HOME/.zprezto"
    for rc in "$MD"/runcoms/z*
    do
        echo "Linking $rc -> $HOME/.$(basename ${rc})"
        ln -s "$rc" "$HOME/.$(basename ${rc})"
    done
}

_remove() {
    unlink "$HOME/.zpreztorc"
    for rc in "${MD}"/runcoms/z*
    do
        unlink "$HOME/.$(basename ${rc})"
    done
}

_info() {
    echo -n "ZPrezto - Instantly Awesome zsh" && \
        is_installed ~/.zpreztorc && \
        echo " - [Installed]" || echo ""
}

run_if ubuntu18 arch osx
