#!/usr/bin/env bash
#taken from ThePrimeagen

search_paths=(
  ~/Documents/Code
  ~/Documents/Code/college
  ~/Documents/Code/PicCollage
  ~/Documents/Code/other
  ~/Documents/Code/web
)

teamocil_layouts_path="$HOME/.teamocil"

search_paths_str="${search_paths[*]}"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find $search_paths_str -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi


selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

teamocil_layout="$teamocil_layouts_path/$selected_name.yml"

setup_layout() {
  if [[ -f $teamocil_layout ]]; then
    echo "Setting up layout for $selected_name"
    tmux send -t $selected_name "teamocil $selected_name --here" ENTER
    return
  fi

  tmux send -t $selected_name "echo 'No layout found for $selected_name', you can create one at $teamocil_layout" ENTER
}

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    echo "Starting tmux"
    tmux new-session -ds $selected_name -c $selected
    setup_layout
elif ! tmux has-session -t=$selected_name 2> /dev/null; then
    echo "Creating new session"
    tmux new-session -ds $selected_name -c $selected
    setup_layout
fi

if [[ -n "$TMUX" ]]; then
    echo "Switching to session $selected_name"
    tmux switch -t $selected_name
    exit 0
fi

echo "Attaching to session $selected_name"
tmux attach-session -t $selected_name

