# Conda environment related aliases
export MY_CONDA_ENVS="/Users/Kyle/miniconda3/envs"  # wherever you want to save your environments
alias build_new_env="sh /Users/Kyle/build_new_env.sh"
alias del_curr_env="sh /Users/Kyle/del_env.sh"
alias activ_curr_env='conda activate $MY_CONDA_ENVS/${PWD##*/}'


# Terminal helpers
alias ll="ls -all"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

cat /Users/Kyle/hey_friend.txt
