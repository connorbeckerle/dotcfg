dotfiles!

https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
https://www.atlassian.com/git/tutorials/dotfiles

To migrate to new system:
1. set up alias in .bashrc, run in current shell scope
    alias config='/usr/bin/git --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'
2. avoid recursion problem
    echo ".dotcfg" >> .gitignore
3. clone into bare repo
    git clone --bare <git-repo-url> $HOME/.dotcfg
4. checkout content from bare repo
    config checkout
    # NOTE - if this fails, it might be because you have stuff there already, move it
5. don't check untracked files
   config config --local status.showUntrackedFiles no

    

