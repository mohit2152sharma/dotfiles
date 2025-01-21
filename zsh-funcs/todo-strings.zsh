# extract todo, fixme, bugs strings from a directory or a file
function clean_strings() {
  local strings="$1"
  local pattern="$2"
  echo "$strings" | sed "s/^.*${pattern}://" | sed "s/^\s*//" | sed "s/\s*$//"
}


function run_rg() {
  local pattern="$1"
  local file="${2:-.}"

  if ! command -v rg &> /dev/null; then
    echo "rg not found, please install ripgrep"
    return 1
  fi

  strings=$(rg --trim "$pattern" "$file")
  echo "$strings"
}

# TODO: get full path of the file instead of relative
function get_full_path() {
  local strings="$1"

  while read -r string; do
    path=${string%:*}
    echo "file path: $path"
  done <<< "$strings"
}

function get_required_string() {
  local pattern="$1"
  local file="${2:-.}"
  local clean="$3"

  local strings=$(run_rg "$pattern" "$file")

  if [[ -n "$clean" && "$clean" =~ ^(true|TRUE|1|yes|YES|y|Y) ]]; then
    strings=$(clean_strings "$strings" "$pattern")
    return 0
  fi
  echo "$strings"
  return 0
}

function get_todo() {
  local file="${1:-.}"
  get_required_string "\s+TODO:" "$file" no
}

function get_fixme() {
  local file="${1:-.}"
  get_required_string "\s+FIXME:" "$file" no
}

function get_bugs() {
  local file="${1:-.}"
  get_required_string "\s+BUG:" "$file" no
}

# TODO: reformat output string to align with jira summary
# TODO: handle jira summary character limit of 255 characters
function get_todo_fixme_bugs() {
  local file="${1:-.}"
  # BUG: sed returns empty string with regex or pattern
  get_required_string "\s+TODO:|\s+FIXME:|\s+BUG:" "$file" no
}

function todo_alias() {
  local year=$(date +%Y)
  local temp_file=$(mktemp)

  local todo_file_path="$HOME/github/saral/docs/planning/$year/sprint-planning/todo-list.txt"
  # get_todo_fixme_bugs >> "$todo_file_path" | sort | uniq >  "$temp_file" && mv "$temp_file" "$todo_file_path"
  { get_todo_fixme_bugs >> "$todo_file_path" ; cat "$todo_file_path" }  | sort | uniq > "$temp_file" && mv "$temp_file" "$todo_file_path"
}
