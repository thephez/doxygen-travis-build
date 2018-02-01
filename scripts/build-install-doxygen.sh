#!/bin/sh
set -ex

# Build instructions from: https://www.stack.nl/~dimitri/doxygen/download.html
echo "Cloning doxygen repository..."
cd ~/
git clone https://github.com/doxygen/doxygen.git

cd doxygen

# Use v1.8.14 (2f4139de014bf03898320a45fe52c92872c1e0f4)
git checkout 2f4139de014bf03898320a45fe52c92872c1e0f4 .

echo "Create build folder..."
mkdir build
cd build

echo "Make..."
cmake -G "Unix Makefiles" ..
make

echo "Done building doxygen..."
./bin/doxygen

echo "Install Doxygen"
cp ./bin/* $TRAVIS_BUILD_DIR
make install

cd $TRAVIS_BUILD_DIR
