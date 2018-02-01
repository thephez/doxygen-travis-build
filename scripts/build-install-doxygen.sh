#!/bin/sh
set -ex

# Build instructions from: https://www.stack.nl/~dimitri/doxygen/download.html
echo "Cloning doxygen repository..."
cd ~/
git clone https://github.com/doxygen/doxygen.git

cd doxygen

echo "Create build folder..."
mkdir build
cd build

echo "Make..."
cmake -G "Unix Makefiles" ..
make

echo "Done building doxygen..."
./bin/doxygen

echo "Install Doxygen"
make install

cd $TRAVIS_BUILD_DIR
