#!/usr/bin/env bash
# entrypoint.sh
# Runs at container startup, after bind mounts are in place.
set -euo pipefail

MITSUBA_DIR="/workspace/mitsuba3"

# Clone Mitsuba3 if not already present.
if [ ! -d "$MITSUBA_DIR/.git" ]; then
    echo "[entrypoint] Cloning Mitsuba3 (${GITHUB_USER}/mitsuba3@${MITSUBA_REF})..."
    git clone --recurse-submodules \
        --branch "$MITSUBA_REF" \
        "https://github.com/${GITHUB_USER}/mitsuba3.git" \
        "$MITSUBA_DIR"
else
    echo "[entrypoint] Mitsuba3 source already present, updating (no full clone)..."
    # Make sure submodules are initialised (e.g. after a fresh clone on host).
    git -C "$MITSUBA_DIR" submodule update --init --recursive
fi
