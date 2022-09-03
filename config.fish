# FISH SHELL CONFIGURATION {{{1
# vim: foldmethod=marker:foldlevel=0:nofoldenable:
# AUTHOR: Sri Kadimisetty



# NIX {{{1
# NOTE: Place as close to top as possible to make nix pkgs available immediately.
if test -e "$HOME/.nix-profile/etc/profile.d/nix.sh"
  eval (bash -c "source $HOME/.nix-profile/etc/profile.d/nix.sh; echo export NIX_PATH=\"\$NIX_PATH\"; echo export PATH=\"\$PATH\"")
end
alias ne='nix-env'
alias neh='nix-env --help'
alias nei='nix-env --install'
alias neiattr='nix-env --install --attr'
alias neuninstall='nix-env --uninstall'
alias neq='nix-env --query --description'
alias neqi='nix-env --query --installed --description'
alias neqa='nix-env --query --available --description'
alias nelg='nix-env --list-generations'
alias nesg='nix-env --switch-generation'
alias ns='nix-shell'




# COMMON PREFERENCES {{{1
# DISABLE WELCOME GREETING:
set fish_greeting ""
# THEME:
fish_config theme choose Dracula
# RELOAD `config.fish` WITH `rf`:
abbr --add --global rf 'source ~/.config/fish/config.fish'
# DEFAULT EDITOR:
set --export EDITOR vim
set --export VISUAL vim
# ENABLE VI MODE:
fish_vi_key_bindings
# SET VIM CURSOR STYLES:
set fish_cursor_default block   # `default` includes normal and visual modes
set fish_cursor_insert line
set fish_cursor_replace_one underscore
# PUT PERSONAL EXECUTABLES ON PATH (Create `~/bin/` if not present):
mkdir -p $HOME/bin
fish_add_path $HOME/bin/
# PUT COMMONLY USED BIN PATH ON PATH (used by `stack` etc.):
mkdir -p $HOME/.local/bin
fish_add_path $HOME/.local/bin




# COMMON ALIASES {{{1
alias l="ls --almost-all"
alias rmi="rm -i"
function mcd  --description "`mkdir` and `cd` into new directory"
    mkdir $argv
    and cd $argv
end
# QUICK `cd` INTO DIRS IN HERE:
set CDPATH $HOME/code/
# COMMONLY VISITED DIRS:
alias sandbox="cd ~/code/sandbox"
alias playground="cd ~/code/playground/"
alias personal="cd ~/code/personal"
alias dotfiles="cd $HOME/code/personal/dotfiles/"




# PROMPT {{{1
# VIM MODE PROMPT:
function fish_mode_prompt
    switch $fish_bind_mode
        case insert
            echo -s                                                 \
            (set_color --bold brblack --dim)                "  I  "
        case default
            echo -s                                                 \
            (set_color yellow)                              " "    \
            (set_color --background yellow black --bold)    "N"     \
            (set_color yellow --background normal)          " "
        case replace_one
            echo -s                                                 \
            (set_color brgreen)                             " "    \
            (set_color --background brgreen black --bold)   "r"     \
            (set_color brgreen --background normal)         " "
        case replace
            echo -s                                                 \
            (set_color brgreen)                             " "    \
            (set_color --background brgreen black --bold)   "R"     \
            (set_color brgreen --background normal)         " "
        case visual
            echo -s                                                 \
            (set_color brmagenta)                           " "    \
            (set_color --background brmagenta black --bold) "v"     \
            (set_color brmagenta --background normal)       " "
        case "*"
            echo -s                                                 \
            (set_color brred)                               " "    \
            (set_color --background brred black --bold)     "?"     \
            (set_color brred --background normal)           " "
    end
    set_color normal
end
# LEFT PROMPT:
function fish_prompt --description "Left prompt"
    # NOTE: `$status` has to be collected right away, so place first.
    set --local _previous_command_status $status

    # If not sudo calculate prompt symbol based on success/failure.
    if test $_previous_command_status = 0
        # `$status` is SUCESS i.e. 0
        set _prompt_symbol ""
    else
        # `$status` is FAILURE i.e. 1/12/123/124/125/126//127
        set _prompt_symbol ""
    end
    # Override prompt if root
    fish_is_root_user; and set _prompt_symbol '#'

    if test $_previous_command_status = 0
        # `$status` is SUCESS i.e. 0
        # (set_color $fish_color_operator) $_prompt_symbol   \
        echo -s                                                 \
            (set_color white) (prompt_pwd) " "                  \
            (set_color $fish_color_redirection --dim) $_prompt_symbol \
            (set_color normal ) " "
    else
        # `$status` is FAILURE i.e. 1/12/123/124/125/126//127
        echo -s                                             \
            (set_color white) (prompt_pwd) " "              \
            (set_color $fish_color_error) $_prompt_symbol   \
            (set_color normal ) " "
    end
end
# RIGHT PROMPT:
function fish_right_prompt --description "Right prompt"
    echo -s (set_color brblack) (fish_git_prompt)
end
# GIT PROMPT SETTINGS:
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_use_informative_chars
set __fish_git_prompt_char_stateseparator " "
# GIT PROMPT GENERAL COLORS:
set __fish_git_prompt_color "brblack"
set __fish_git_prompt_color_bare "blue"
set __fish_git_prompt_color_prefix "black"
set __fish_git_prompt_color_suffix "black"
# GIT PROMPT CLEAN STATE:
set __fish_git_prompt_char_cleanstate "●"
set __fish_git_prompt_color_cleanstate "brblack"
# GIT PROMPT DIRTY STATE (UNSTAGED FILES) WITH CHANGES EXIST:
set __fish_git_prompt_showdirtystate
set __fish_git_prompt_char_dirtystate ""
set __fish_git_prompt_color_dirtystate "brred"
# GIT PROMPT STAGED FILES WITHOUT ADDITIONAL CHANGES EXIST:
set __fish_git_prompt_char_stagedstate ""
set __fish_git_prompt_color_stagedstate "yellow"
# GIT PROMPT UNTRACKED FILES EXIST:
set __fish_git_prompt_showuntrackedfiles
set __fish_git_prompt_char_untrackedfiles ""
set __fish_git_prompt_color_untrackedfiles "brmagenta"
# GIT PROMPT INVALID STATE (IN FISH "UNMERGED" CHANGES ARE ADDITIONAL CHANGES TO ALREADY ADDED FILES):
set __fish_git_prompt_char_invalidstate ""
set __fish_git_prompt_color_invalidstate "brred"
# GIT PROMPT UPSTREAM AND DOWNSTREAM DIFFERENCES:
set __fish_git_prompt_showupstream "auto"
set __fish_git_prompt_char_upstream_ahead " "
set __fish_git_prompt_char_upstream_behind " "
set __fish_git_prompt_color_upstream "yellow"
# TODO: LOOK INTO `*_DONE` COLORS:
#   https://fishshell.com/docs/current/cmds/fish_git_prompt.html?highlight=git
#   set __fish_git_prompt_color_upstream_done "green"
# GIT PROMPT STASH:
set __fish_git_prompt_showstashstate
set __fish_git_prompt_char_stashstate ""
set __fish_git_prompt_color_stashstate "brblack"




# LSD {{{1
# TODO: [Setup configuration](https://github.com/Peltoche/lsd#configuration)
alias lsdll='lsd --long'
alias lsdt='lsd --tree'
alias lsdl='lsd --tree --depth'
alias lsd1='lsd --tree --depth 1'
alias lsd2='lsd --tree --depth 2'
alias lsd3='lsd --tree --depth 3'




# GIT {{{1
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --decorate --graph'




# FZF {{{1
#   NOTE: Use ripgrep to power fzf searches:
#           --files             : Print files'names but not their content
#           --hidden            : Search hidden files and directories
#           --smart-case        : Search smart with upper and lower case
#           --glob "!.git/*"    : Ignore .git/ folder
set --export FZF_DEFAULT_COMMAND 'rg --files --hidden --smart-case --glob "!.git/*"'

function _fzf_search_history --description "Search command history with `fzf`"
    # Get history and pipe into fzf
    history --null |
        # Run fzf on received string. (TODO: Check if `fzf` installed)
        fzf \
            # Prefill query with command line content
            --query=(commandline)  \
            # Multi-select with (Shift)Tab
            --multi \
            # Read input delimited by ascii null
            --read0 \
            # Print input delimited by ascii null
            --print0 \
            # Not fullscreen but w/ this height under cursor
            --height=10 \
            # Strategy to use when scores are tied
            --tiebreak=index |
        # Split string received on null byte
        string split0 |
        # Remove trailing newlines on string received.
        # TODO: Replace with `string` command.
        tr --delete '\n' |
        # Store received string into `$result`
        read --local --null result
    # Run only if previous command succeeds,
    # replacing commandline with previous result.
    and commandline --replace -- $result

    # Repaint commandline. Necessary to avoid UI glitches.
    commandline --function repaint
end
# Trigger fzf search with `<C-r>`
bind \cr --mode default _fzf_search_history
bind \cr --mode insert _fzf_search_history




# DIRENV {{{1
# SEE: https://direnv.net/docs/hook.html#fish
# HOOK INTO FISH SHELL:
direnv hook fish | source
# TRIGGER DIRENV AT PROMPT ONLY (original behavior in other shells):
# set -g direnv_fish_mode disable_arrow




# -----------------------------------------------------------------------
# VIM {{{1
alias v="vim"
alias vc="vim --clean"
alias vf="vim --clean -S ~/.fresh-new-vimrc.vim"
alias vn='vim -c "NERDTree"'
alias vno='vim -c "NERDTree | normal O"'
alias vs="vim -S ./Session.vim"
alias viewn='view -c "NERDTree"'
alias viewno='vim -c "NERDTree | normal O"'
alias vg='vim -c "call ToggleGVCommitBrowser(\'GV\')"'
alias vp="vim -c FZFFiles"
alias vpr="vim -c FZFRg"
alias vo='vim -o'
alias vO='vim -O'
alias vt='vim -p'




# NVIM {{{1
alias n="nvim"
alias nview="nvim -R"




# TMUX/TMUXINATOR {{{1
# TMUX:
alias t="tmux"
alias tls="tmux list-sessions"
function tat  --description "Attach tmux to a running session with name provided as arg"
    tmux attach -t $argv
end
# TMUXINATOR:
alias tst="tmuxinator start ./.tmuxinator.yml"




# ELIXIR/MIX/PHOENIX {{{1
function mxncd --description "Does `mix new` and `cd`s into the new dir"
    if mix new $argv;
        cd $argv
    end
end
function mxpncd --description "Does `mix phx.new` and `cd`s into the new dir"
    if mix phx.new $argv;
        cd $argv
    end
end
alias ix="iex"
alias ixm="iex -S mix"
alias mx="mix"
alias mxn="mix new"
alias mxb="mix build"
alias mxc="mix compile"
alias mxec="mix ecto.create"
alias mxem="mix ecto.migrate"
alias mxt="mix test"
alias mxtt="mix test --trace" # run tests synchronously
alias mxpn="mix phx.new"
alias mxps="mix phx.server"




# DJANGO {{{1
function _exit_if_not_in_active_python_virtual_env --description "Exit w/ failure if not in python virtual environment"
    if ! test -n "$VIRTUAL_ENV"
        set_color $fish_color_error
        echo "ERROR: Not in virtual env" >&2
        set_color $fish_color_normal
        and false # return with failure code
    end
end
# MANAGE.PY ALIASES:
function activate  --description "activate python virtual environment in `./venv`"
    source ./venv/bin/activate.fish
end
function mp     --description "./manage.py"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py
end
function mprs   --description "./manage.py runserver"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py runserver
end
function mpcs   --description "./manage.py collectstatic"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py collectstatic
end
function mpcsu  --description "./manage.py createsuperuser"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py createsuperuser
end
function mpm    --description "./manage.py migrate"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py migrate
end
function mpmm   --description "./manage.py makemigrations"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py makemigrations
end
function mps    --description "./manage.py shell"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py shell
end
function mpsa   --description "./manage.py startapp"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py startapp
end
function mpt    --description "./manage.py test"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py test
end
function mpts   --description "./manage.py testserver"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py testserver
end
# [django-extension](https://github.com/django-extensions/django-extensions):
function mpsu   --description "./manage.py show_urls"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py show_urls
end
function mpvt   --description "./manage.py validate_templates"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py validate_templates
end
function mpsp   --description "./manage.py shell_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py shell_plus
end
function mprsp  --description "./manage.py runserver_plus"
    _exit_if_not_in_active_python_virtual_env
    and ./manage.py runserver_plus
end




# RUST/CARGO {{{1
function cncd --description "Does `cargo new` and `cd`s into the new dir"
    if cargo new $argv;
        cd $argv
    end
fish_add_path $HOME/.cargo/bin/
end
alias c="cargo"
alias ca="cargo add"
alias cb="cargo build"
alias cbq="cargo build --quiet"
alias ccheck="cargo check"
alias cclippy="cargo clippy"
alias cfix="cargo fix"
alias cfmt="cargo fmt"
alias cn="cargo new"
alias cr="cargo run"
alias crq="cargo run --quiet"
alias ct="cargo test"
alias ctq="cargo test --quiet"
alias ctreed1="cargo tree --depth 1"
alias cw="cargo watch"
alias cwq="cargo watch --quiet"




# HASKELL/STACK/CABAL {{{1
# TODO: Automatically add relevant stack/ghci compiler tool location.
#       e.g. `export PATH=$HOME/.stack/compiler-tools/x86_64-osx/ghc-8.8.3/bin:$PATH`
function stncd --description "Does `stack new` and `cd`s into the new dir"
    if stack new $argv;
        cd $argv
    end
end
alias stb="stack build"
alias stbf="stack build --fast"
alias stc="stack clean"
alias ste="stack exec"
alias stg="stack ghci"
alias stn="stack new"
alias str="stack run"
alias stt='stack test'




# GO {{{1
fish_add_path $HOME/go/bin
alias gob='go build'
alias gof='go fmt'
alias gom="go mod"
alias gomi="go mod init"
alias gomt="go mod tidy"
alias gor.='go run .'
alias gor='go run'
alias got='go test'




# NODE/NVM {{{1
# NOTE: SEE: https://github.com/nvm-sh/nvm#fish
# DESIRED LOCATION: ~/.config/fish/functions/nvm.fish
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
# DESIRED LOCATION: ~/.config/fish/functions/nvm_find_nvmrc.fish
function nvm_find_nvmrc
  bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
end
# DESIRED LOCATION: ~/.config/fish/functions/load_nvm.fish
function load_nvm --on-variable="PWD"
  set -l default_node_version (nvm version default)
  set -l node_version (nvm version)
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
    if test "$nvmrc_node_version" = "N/A"
      nvm install (cat $nvmrc_path)
    else if test "$nvmrc_node_version" != "$node_version"
      nvm use $nvmrc_node_version
    end
  else if test "$node_version" != "$default_node_version"
    # echo "Reverting to default Node version"
    nvm use default --silent
  end
end
# DESIRED LOCATION: ~/.config/fish/config.fish
# You must call it on initialization or listening to directory switching won't work
load_nvm > /dev/stderr




# LUA/LUAROCKS {{{1
fish_add_path $HOME/.luarocks/bin/
set --export luarocks "luarocks --local"




# ANYTHING BELOW THIS WAS ADDED AUTOMATICALLY AND NEEDS TO BE SORTED {{{1
