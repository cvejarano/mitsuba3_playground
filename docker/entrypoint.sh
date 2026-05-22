#!/usr/bin/env bash
# entrypoint.sh
# Runs at container startup, after bind mounts are in place.
set -euo pipefail

echo "[entrypoint] Starting Marimo server..."
uv run marimo edit /workspace/notebooks \
    --host 0.0.0.0 \
    --port 2719 \
    --no-token &

# Hand off to the container command
echo "[entrypoint] Ready."
exec "$@"
