#!/usr/env/bin bash

# Create a new route in a svelte project
# User provide the route name and the script will create a new
# folder with the route name and the +page.svelte file and +page.server.ts file
# in the route directory throws error if the directory already exists
# This is intended to be run from the `src/routes` directory
# Usage: svelte-route -r <route-name> -l <language>

function create_svelte_file() {
  local dir_name="$1"
  local lang="$2"

  local file_name="${dir_name}/+page.svelte"

  echo -e "<script lang=\"${lang}\">\n\n</script>" >"$file_name"
}

function create_server_file() {
  local dir_name="$1"
  local lang="$2"

  if [[ "$lang" == "ts" || "$lang" == "typescript" ]]; then
    local file_type="ts"
  elif [[ "$lang" == "js" || "$lang" == "javscript" ]]; then
    local file_type="js"
  else
    echo "inavlid language value, valid values are: ts/js/javascript/typescript"
    return 1
  fi

  local file_name="${dir_name}/+page.server.${file_type}"
  touch "$file_name"
}

function create_route() {
  local route_name=${1:?"route name not provided"}
  local lang=${2:?"language name not provided, valid values are: ts/js/javascript/typescript"}

  if [[ -d "$route_name" ]]; then
    echo "Route already exists, aborting"
    return 1
  fi

  mkdir "$route_name"
  dir_path="$(pwd)/${route_name}"
  create_svelte_file "$dir_path" "$lang"
  create_server_file "$dir_path" "$lang"
}
