# git add all then commit with jira ticket number and then push
function gacp() {
    local jira_no=$(git branch --show-current | grep -Eo "^SAR-\d+")
    local msg="${(j[ ])@}"
    if [[ -n "$jira_no" ]]; then 
        msg="$jira_no $msg"
        echo "committing with message: $msg"
    fi

    git add --all;
    git commit -m "$msg";
    git push
}

function logrunvars() {
    echo "RUN_ENV=$RUN_ENV, MY_ENV=$MY_ENV, MY_REGION=$MY_REGION"
}

# set env vars to test environment
function envt() {
    export RUN_ENV=test
    export MY_ENV=test
    export MY_REGION=ap-south-1

    load_dot_files ~/github/saral/saral-backend/.env.test
    logrunvars
}

function envl() {
    echo 'changing to local env'
    export RUN_ENV=local
    export MY_REGION=ap-south-1

    load_dot_files ~/github/saral/saral-backend/.env.local
    logrunvars
}
# set env vars to prod environment
function envp() {
    export RUN_ENV=prod
    export MY_ENV=prod
    export MY_REGION=us-west-2

    load_dot_files ~/github/saral/saral-backend/.env.prod

    logrunvars
}

# load a given dot file, the environment variables must of the form MY_VAR=value
function load_dot_files() {
    local file_path="$1"

    if [[ ! -f "$file_path" ]]; then 
        echo "not a valid file path ""$file_path"", skipping"
    else 
        while read -r line; do 
            export "$line"
        done < "$file_path"
    fi
}

# create a planning doc for the current sprint
function create_planning_doc() {
    source "$HOME/github/saral/docs/.venv/bin/activate"
    python "$HOME"/github/saral/docs/create_planning_doc.py 
    deactivate
}

# create a pr on github for the current branch and default base
function create_pr() {
    local branch_name=$(git branch --show-current)
    local base_branch="${1:-"saral-v4"}"
    gh pr create --base "$base_branch" --head "$branch_name" --fill-verbose
}

# remove vim swap files and clean the swap directory
function remove_swap_files() {
    rm -rf "$HOME"/.local/state/nvim/swap/* 
}
