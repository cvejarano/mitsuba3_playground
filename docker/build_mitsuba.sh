# Build instructions adapted from:
# https://mitsuba.readthedocs.io/en/stable/src/developer_guide/compiling.html.
# At the end, we set some environment variables; for these to be visible to your
# current terminal, invoke run this script with `source build_mitsuba.sh`.
set -e

# -----
echo "Preparing Mitsuba3 build..."
cd /workspace/mitsuba3
rm -rf build

mkdir build
cd build
cmake -GNinja -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_BUILD_TYPE=Release .. 

# -----
echo "Building Mitsuba3..."
ninja

# -----
echo "Installing Mitsuba3 Python package..."
uv pip install --editable /workspace/mitsuba3