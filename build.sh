set -e

cd clone
git checkout temp

git submodule update --init --recursive --depth 1 submodules/openscad/openscad

cd submodules/openscad/openscad

if [ "$(uname)" == "Darwin" ]; then
  source setenv_mac.sh
  ./scripts/macosx-build-dependencies.sh
  qmake openscad.pro
  make -j 2
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  sudo apt-get install libglew-dev libxmu-dev libxi-dev qt5-default qtmultimedia5-dev libboost-filesystem-dev libeigen3-dev libmpc-dev libqscintilla2-qt5-dev libcgal-dev libdouble-conversion-dev harfbuzz-dev -y
  source ./scripts/setenv-unibuild.sh
  ./scripts/check-dependencies.sh
  qmake openscad.pro
  make -j 2
else
  source ./scripts/setenv-mingw-xbuild.sh 64
  ./scripts/mingw-x-build-dependencies.sh 64
  ./scripts/release-common.sh mingw64
  cd mingw64
  qmake ../openscad.pro CONFIG+=mingw-cross-env
  make -j 2
fi
