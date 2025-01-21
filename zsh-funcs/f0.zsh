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

# set env vars to test environment
function envt() {
    export MY_ENV=test
    export MY_REGION=ap-south-1
}

# set env vars to prod environment
function envp() {
    export MY_ENV=prod
    export MY_REGION=us-west-2
}

# load a given dot file, the environment variables must of the form MY_VAR=value
function load_dot_files() {
    local file_path="$1"

    if [[ ! -f "$file_path" ]]; then 
        echo "not a valid file path "$file_path", skipping"
    else 
        while read -r line; do 
            export "$line"
        done < "$file_path"
    fi
}

# create a planning doc for the current sprint
function create_planning_doc() {
    conda activate docs
    python "$HOME"/github/saral/docs/create_planning_doc.py 
    conda deactivate
}
