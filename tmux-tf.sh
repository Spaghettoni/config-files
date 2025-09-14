#!/bin/bash
tmux kill-session -t tf 2>/dev/null
tmux new-session -d -s tf -n git -c ~/projects/tfaa-monorepo

tmux new-window -t tf:1 -n dev -c ~/projects/tfaa-monorepo
tmux split-window -h -t tf:1.0 -p 30 -c ~/projects/tfaa-monorepo/frontend
tmux split-window -v -t tf:1.1 -c ~/projects/tfaa-monorepo/backend
tmux send-keys -t tf:1.0 'hx .' C-m

tmux new-window -t tf:2 -n address -c ~/projects/address-lookup
tmux send-keys -t tf:2.0 '
PID=$(lsof -ti :4269) && [ -n "$PID" ] && kill -9 $PID;
nvm use && npm run dev
' C-m

tmux select-window -t tf:1
tmux select-pane -t tf:1.0

tmux attach-session -t tf
