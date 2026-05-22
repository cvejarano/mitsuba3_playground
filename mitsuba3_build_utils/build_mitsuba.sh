# Build instructions, adapted from:
# https://mitsuba.readthedocs.io/en/stable/src/developer_guide/compiling.html.
set -euo pipefail

# -----
echo "Preparing Mitsuba3 build..."
cd /workspace/mitsuba3

mkdir -p build
cd build
# Use the custom config file in the repo.
cp /workspace/mitsuba3_build_utils/custom_mitsuba.conf ./mitsuba.conf
cmake -GNinja -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_BUILD_TYPE=Release ..

# -----
echo "Building Mitsuba3..."
ninja

# -----
# Note that installing with uv pip install will
# create the uv environment if it didn't exist.
if ! uv pip show mitsuba > /dev/null 2>&1; then
    echo "Installing Mitsuba3 Python package..."
    uv pip install --editable /workspace/mitsuba3
else
    echo "Mitsuba3 already installed, skipping."
fi
