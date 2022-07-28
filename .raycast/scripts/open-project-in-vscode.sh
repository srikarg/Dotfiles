#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Project
# @raycast.mode compact
# @raycast.packageName VS Code

# Optional parameters:
# @raycast.icon images/vscode.png
# @raycast.argument1 { "type": "text", "placeholder": "Directory Name", "optional": false }

# Documentation
# @raycast.description Finds path to the given directory which must be a VSCode or Git project and opens it with VSCode
# @raycast.author Maksim Zemlyanikin
# @raycast.authorURL https://github.com/Maksimka101

PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

directory=$1
foundDirectory=''

if [ -z "$directory" ]; then
  echo "Empty directory is not allowed"
  exit 1
fi

set +e
directories=$(fd "$directory" "$HOME" -t d --max-depth 5)
for dir in $directories; do
  if [[ -n "$(fd .vscode "$dir" -t d --max-depth 1)" || -n "$(fd .git "$dir" -t d --max-depth 1)" ]]; then
    foundDirectory=$dir
  fi
done

if [ -n "$foundDirectory" ]; then
  echo "Project directory is $foundDirectory"
  code -n "$foundDirectory"
else
  echo "No such directory in '$HOME' with name $1"
fi
exit 0
