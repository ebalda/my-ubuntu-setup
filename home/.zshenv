# envs (constants)
export POETRY_CACHE_DIR=$HOME/.cache/pypoetry
export VIRTUAL_ENV_DISABLE_PROMPT=0

CUSTOM_SCRIPTS_DIR=$HOME/.custom_scripts
CUSTOM_ICONS_DIR=$HOME/.custom_icons

export PYENV_ROOT="$HOME/.pyenv"
export CLOUDSDK_PYTHON=/usr/bin/python3.8

# aliases and functions
alias pip="python3 -m pip"
alias pip3="python3 -m pip"
alias gs="gst"
alias kc="kubectl"
alias srm="gio trash"
alias activate="source $CUSTOM_SCRIPTS_DIR/activate_env.sh"
alias zshi="source $CUSTOM_SCRIPTS_DIR/zshi.sh"
alias texmake="latexmk -pdf -pvc -interaction=nonstopmode"
alias set-custom-icons="bash $CUSTOM_ICONS_DIR/link_icons.sh"
alias wally="$HOME/opt/wally/wally"
alias env-to-json="python3 $CUSTOM_SCRIPTS_DIR/env2json.py | jq"
alias latest-version="yolk -V"

alias aixwork="cd $CORE_DIR"
function aixcli() {
    current_dir=$PWD
    tools_path=${CORE_DIR}/projects/tools
    cd $tools_path
    env_path="$(cd ${tools_path} && poetry env list --full-path)"
    py_path=$(echo $env_path | sed 's/ (Activated)//')
    # ${py_path}/bin/python3 tools/cli.py $@;  #! sometimes wierd behavior
    poetry run python tools/cli.py $@
    cd $current_dir
}

poetry config cache-dir $POETRY_CACHE_DIR

function delete-evicted-pods() {
    kubectl get po -A | grep Evicted | awk '{system ("kubectl -n " $1 " delete po " $2)}'
}

function clean-branches() {
    git fetch origin
    git branch --merged >/tmp/merged-branches
    nano /tmp/merged-branches
    xargs git branch -d </tmp/merged-branches
    git remote prune origin
}

function install-all-projects() {
    current_dir=$PWD
    for PROJECT_NAME in $(ls ${CORE_DIR}/projects); do
        cd ${CORE_DIR}/projects/${PROJECT_NAME}
        if [ -f "${CORE_DIR}/projects/${PROJECT_NAME}/poetry.lock" ] && [ $PROJECT_NAME != "betterflow" ]; then
            echo "\033[1;36m##################################################"
            echo "Installing ${PROJECT_NAME}"
            echo "################################################## \033[0m"
            poetry install
        fi
    done
    cd $current_dir
}
function install-all-libs() {
    current_dir=$PWD
    for LIB_NAME in $(ls ${CORE_DIR}/lib); do
        cd ${CORE_DIR}/lib/${LIB_NAME}
        if test -f "${CORE_DIR}/lib/${LIB_NAME}/poetry.lock"; then
            echo "\033[1;36m##################################################"
            echo "Installing aixbrain.${LIB_NAME}"
            echo "################################################## \033[0m"
            poetry install
        fi
    done
    cd $current_dir
}
function test-all-projects() {
    for PROJECT_NAME in $(ls ${CORE_DIR}/projects); do
        if [ -f "${CORE_DIR}/projects/${PROJECT_NAME}/poetry.lock" ] && [ $PROJECT_NAME != "betterflow" ]; then
            echo "\033[1;36m##################################################"
            echo "Testing ${PROJECT_NAME}"
            echo "################################################## \033[0m"
            aixcli test-runner ${PROJECT_NAME}
        fi
    done
}

alias show-venvs="du -h --max-depth 1 ${POETRY_CACHE_DIR}/virtualenvs"

alias use-prod-cluster="gcloud container clusters get-credentials prod-cluster --zone europe-west1-c --project aixbrain-core"
alias use-private-cluster="gcloud container clusters get-credentials private-prod-cluster --zone europe-west1-b --project aixbrain-core"
alias delete-evicted-pods="delete_evicted_pods"
alias docker-clean-images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker-clean-ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias docker-delete-all-ps='docker rm -vf $(docker ps -aq)'
alias docker-delete-all-images='docker rmi -f $(docker images -aq)'

function mv-image() {
    docker pull $1
    docker tag $1 $2
    docker push $2
}

alias postgres-db-up="sudo -u postgres psql postgres"

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Append to global PATH(s)
export PATH=$PATH:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.local/bin:$HOME/.poetry/bin
export PATH=:$PATH:$HOME/android-studio/bin
export PATH="$PATH:/opt/mssql-tools/bin" # to make pyodbc drives work
export PYTHONPATH=:$CORE_DIR
export PATH=$PATH:$HOME/.pulumi/bin
export PATH="$HOME/.poetry/bin:$PATH"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ebalda/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ebalda/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ebalda/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ebalda/google-cloud-sdk/completion.zsh.inc'; fi
