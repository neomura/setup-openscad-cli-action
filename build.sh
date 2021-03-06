set -e

cd clone


if [ "$(uname)" == "Darwin" ]; then
  cd submodules/openscad/openscad
  qmake openscad.pro
  make -j 6
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  git checkout temp
  git submodule update --init --recursive --depth 1 submodules/openscad/openscad
  cd submodules/openscad/openscad
  sudo apt-get install gettext itstool -y
  source ./scripts/setenv-unibuild.sh
  ./scripts/check-dependencies.sh
  qmake openscad.pro
  make -j 4
else
  git checkout temp
  git submodule update --init --recursive --depth 1 submodules/openscad/openscad
  cd submodules/openscad/openscad
  source ./scripts/setenv-mingw-xbuild.sh 64
  ./scripts/mingw-x-build-dependencies.sh 64
  ./scripts/release-common.sh mingw64
  cd mingw64
  qmake ../openscad.pro CONFIG+=mingw-cross-env
  make -j 4
fi
