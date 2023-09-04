#!/usr/bin/env fish

# DESCRIPTION:
#   Sets up a customized django project in current directory.
# AUTHOR:
#   Sri Kadimisetty
# INSTALLATION:
#   - This file can just be used as a regular script file.
#   - This file can also be made available from `$PATH`. A good location would be `~/bin/`.
#   - Make this file executable with `$ chmod u+x djangoinit.fish`
# REQUIREMENTS:
#   - This script hould not be executed in an active python virtual environment.
#   - The current directory should be empty.
# USAGE:
#   - If this file is made executable, it can be run with `$ djangoinit.fish`
#   - The file can also be executed directly by passing to fish like `$ fish ./djangoinit.fish`


function djangoinit
    function _echo_error --description "Print given error message to stderr"
        set_color $fish_color_error
        echo -e ">>> ERROR:" $argv >&2
        set_color $fish_color_normal
    end

    function _echo_header --description "Print section header"
        echo
        set_color $fish_color_operator
        echo ">>> INIT:" $argv
        set_color $fish_color_normal
    end

    function _echo_footer --description "Print section footer"
        set_color $fish_color_operator
        echo ">>> DONE:" $argv
        set_color $fish_color_normal
        echo
    end

    # REQUIREMENTS
    if test -n "$VIRTUAL_ENV"
        _echo_error "Should not be in an active python virtual environment."
        return 1
    else if test -n "$(ls -A ./)" # `-A` instead of `--almost-all` for macos
        _echo_error "Current directory should be empty."
        return 1
    end
    # [git-ignore](https://github.com/sondr3/git-ignore)
    for requiredBinary in python3 git git-ignore
        if ! type -q $requiredBinary
            _echo_error "ERROR: Cannot find `$requiredBinary` in `\$PATH`."
            return 1
        end
    end

    # BEGIN
    _echo_header DJANGO_INIT

    # VENV
    _echo_header "SETTING UP VIRTUAL ENVIRONMENT"
    python3 -m venv ./venv
    source ./venv/bin/activate.fish
    _echo_footer "SETTING UP VIRTUAL ENVIRONMENT"

    # DJANGO
    _echo_header "INSTALLING LATEST DJANGO v4.*"
    pip install --upgrade 'django==4.*'
    echo "DONE INSTALLING LATEST DJANGO v4.*"
    _echo_footer "INSTALLING LATEST DJANGO v4.*"
    _echo_header "STARTING DJANGO PROJECT"
    # Start a django project into the current directory
    # Use current directory name as name of django project
    # django-admin startproject $(basename $PWD) .
    # Use `core` as name of django project
    django-admin startproject core .
    _echo_footer "STARTING DJANGO PROJECT"

    # PLUGINS: DJANGO-EXTENSIONS+DRF
    _echo_header "SETTING UP PLUGINS: DJANGO EXTENSIONS + DRF"
    # Install django_extensions with dependencies
    pip install --upgrade django-extensions werkzeug djangorestframework
    # Insert django_extensions inside settings.py/INSTALLED_APPS
    # with markers for VENDOR and LOCAL apps.
    # NOTE: Using a tempfile as an intermediate for editing with sed.
    set TMP_FILE $(mktemp)
    sed --expression="/'django.contrib.staticfiles',\$/a\    # 3RD PARTY\n\    'django_extensions',\n\    'rest_framework',\n\    # LOCAL" ./core/settings.py >$TMP_FILE
    mv $TMP_FILE ./core/settings.py
    echo "\nTODO: Reorder \`INSTALLED_APPS\` in \`./settings.py\` to place Vendor and Local apps at the end."
    _echo_footer "SETTING UP PLUGINS: DJANGO EXTENSIONS + DRF"

    # BLACK
    _echo_header "FORMATTING WITH BLACK (linelength 79)"
    pip install --upgrade black
    black --line-length 79 .
    pip uninstall black --yes
    _echo_footer "FORMATTING WITH BLACK (linelength 79)"

    # GIT
    _echo_header "SETTING UP GIT + GITIGNORE"
    git-ignore --update django >>.gitignore
    git-ignore --update python >>.gitignore
    git init
    git add --all
    git commit --message="django init"
    _echo_footer "SETTING UP GIT + GITIGNORE"

    # END
    deactivate # Deactivate virtual environment
    _echo_footer DJANGO_INIT
end


# RUN
djangoinit
