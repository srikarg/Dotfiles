for file in ~/.{bash_prompt,exports,aliases,functions,misc}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file
