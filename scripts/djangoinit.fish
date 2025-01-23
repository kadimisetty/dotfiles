#!/usr/bin/env fish

# Setup a django project in current directory according to custom preferences.
# - Sri Kadimisetty

function django-setup-check
    # CHECK 1
    if is_inside_virtual_environment
        echo-ERROR "Should not be in an active python virtual environment."
        return 1
    end
    # CHECK 2
    if not is_cwd_empty
        echo-ERROR "Current directory should be empty."
        return 1
    end
    # CHECK 3: REQUIRED BINARIES EXIST
    # NOTE: [git-ignore](https://github.com/sondr3/git-ignore)
    for requiredBinary in python3 git git-ignore gawk
        if not is_binary_on_path $requiredBinary
            echo-ERROR "Cannot find `$requiredBinary` in `\$PATH`."
            return 1
        end
    end
end

function django-setup
    echo-section_INIT "SETTING UP DJANGO"

    # VENV: INIT
    echo-task_INIT "SETTING UP VIRTUAL ENVIRONMENT"
    python3 -m venv ./venv
    source ./venv/bin/activate.fish
    pip install --upgrade pip
    echo-task_DONE "SETTING UP VIRTUAL ENVIRONMENT"

    # DJANGO
    echo-task_INIT "INSTALLING LATEST DJANGO v5.*"
    pip install --upgrade 'django==5.*'
    echo-task_DONE "INSTALLING LATEST DJANGO v5.*"

    echo-task_INIT "STARTING DJANGO PROJECT (`core`)"
    # Start a django project into the current directory
    # Use current directory name as name of django project
    # django-admin startproject $(basename $PWD) .
    # Use `core` as name of django project
    django-admin startproject core .
    echo-task_DONE "STARTING DJANGO PROJECT (`core`)"

    # PLUGINS: DJANGO-EXTENSIONS, DRF etc.
    echo-task_INIT "SETTING UP DJANGO PLUGINS"
    # Install django_extensions and it's dependencies
    pip install --upgrade django-extensions werkzeug djangorestframework
    # List installed plugins in `settings.py`
    # NOTE: Using a tempfile as an intermediate for editing as gawk's `inplace`
    # isn't working as expected.
    # TODO: Pass in the list of plugins as arguments to `gawk`.
    set TMP_SETTINGS_FILE $(mktemp)
    gawk '
BEGIN { installed_apps_nr = -1; insert_point = -1 }
{ lines[NR] = $0 }
/INSTALLED_APPS/ { installed_apps_nr = NR }
/\]/ { if (installed_apps_nr != -1 && insert_point == -1) insert_point = NR }
END {
  if (installed_apps_nr == -1) {
    for (i=1; i<NR; i++)  print lines[i]
  } else {
    for (i=1; i<insert_point; i++)  print lines[i]
    content = "\n# 3RD PARTY APPS\n\"django_extensions\",\n\"rest_framework\",\n\n# LOCAL APPS"
    print content
    for (i=insert_point; i<NR; i++)  print lines[i]
  }
}' ./core/settings.py >$TMP_SETTINGS_FILE
    mv $TMP_SETTINGS_FILE ./core/settings.py
    echo-task_DONE "SETTING UP DJANGO PLUGINS"

    # BLACK
    echo-task_INIT "FORMATTING WITH BLACK (linelength 79)"
    pip install --upgrade black
    black --line-length 79 .
    pip uninstall black --yes
    echo-task_DONE "FORMATTING WITH BLACK (linelength 79)"

    # GIT
    echo-task_INIT "SETTING UP GIT"
    git-ignore --update python >>.gitignore
    git-ignore --update django >>.gitignore
    git init
    git add --all
    git commit --message="django init"
    echo-task_DONE "SETTING UP GIT"

    # VENV: DONE
    deactivate # Deactivate virtual environment

    echo-section_DONE "SETTING UP DJANGO"
end


# RUN
django-setup-check
and django-setup
