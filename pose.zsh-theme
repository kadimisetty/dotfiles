# Name: pose
# Totally derived from Steve Losh's "prose" theme

#
# Returns the current repositories project name
function collapse_pwd {
    $(git remote -v | head -n1 | awk '{print $2}' | sed 's/.*\///' | sed 's/\.git//')
}


PROMPT='%{$reset_color%}%c %{$fg_bold[blue]%}$(git_prompt_info) ❝ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git.%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}%{$fg[red]%} ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
