set -e

# Unfortunately, the GitHub Actions Marketplace strips out all Git details
# (including submodules) on publish, so we have to re-clone our own repository
# to get the OpenSCAD submodule we plan to build.

mkdir clone
cd clone

git init
git remote add origin https://github.com/$NEOMURA_SETUP_OPENSCAD_CLI_ACTION_REPOSITORY
git fetch origin $NEOMURA_SETUP_OPENSCAD_CLI_ACTION_REF:temp

echo ::set-output name=sha::$(git rev-parse temp)

if [ "$(uname)" == "Darwin" ]; then
  git checkout temp
  git submodule update --init --recursive --depth 1 submodules/openscad/openscad
  cd submodules/openscad/openscad
  ./scripts/macosx-build-homebrew.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo apt-get install libdouble-conversion-dev libboost-regex-dev libglew-dev libxmu-dev libxi-dev qt5-default qtmultimedia5-dev libboost-filesystem-dev libeigen3-dev libmpc-dev libqscintilla2-qt5-dev libcgal-dev libharfbuzz-dev libopencsg-dev -y
else
  echo TODO
fi
