EDITOR=vim
VISUAL=vim
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
alias gs='git status'
alias ga='git add'
alias gps='git push'
alias gpl='git pull'
alias gb='git branch'
alias gc='git commit'
alias gsw='git switch'
alias glol='git log --graph --oneline --decorate'

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats ' (%b)'
precmd() { vcs_info }
setopt PROMPT_SUBST
PROMPT='%~${vcs_info_msg_0_} '

autoload -U compinit
compinit
_comp_options+=(globdots) # With hidden files

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

bindkey -v
export KEYTIMEOUT=1
cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}
cursor_mode

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
