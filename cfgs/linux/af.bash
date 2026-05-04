parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1='\[\033[0;32m\]$(parse_git_branch)\[\033[0m\]\$ '
