#!/bin/sh
################################################################################
# Title         : generateDocumentationAndDeploy.sh
# Date created  : 2016/02/22
# Notes         :
__AUTHOR__="Jeroen de Bruijn"
# Preconditions:
# - Packages doxygen doxygen-doc doxygen-latex doxygen-gui graphviz
#   must be installed.
# - Doxygen configuration file must have the destination directory empty and
#   source code directory with a $(TRAVIS_BUILD_DIR) prefix.
# - An gh-pages branch should already exist. See below for mor info on hoe to
#   create a gh-pages branch.
#
# Required global variables:
# - TRAVIS_BUILD_NUMBER : The number of the current build.
# - TRAVIS_COMMIT       : The commit that the current build is testing.
# - DOXYFILE            : The Doxygen configuration file.
# - GH_REPO_NAME        : The name of the repository.
# - GH_REPO_REF         : The GitHub reference to the repository.
# - GH_REPO_TOKEN       : Secure token to the github repository.
#
# For information on how to encrypt variables for Travis CI please go to
# https://docs.travis-ci.com/user/environment-variables/#Encrypted-Variables
# or https://gist.github.com/vidavidorra/7ed6166a46c537d3cbd2
# For information on how to create a clean gh-pages branch from the master
# branch, please go to https://gist.github.com/vidavidorra/846a2fc7dd51f4fe56a0
#
# This script will generate Doxygen documentation and push the documentation to
# the gh-pages branch of a repository specified by GH_REPO_REF.
# Before this script is used there should already be a gh-pages branch in the
# repository.
#
################################################################################

################################################################################
##### Setup this script and get the current gh-pages branch.               #####
echo 'Setting up the script...'
# Exit with nonzero exit code if anything fails
set -e

# Clone Dash Core
git clone https://github.com/dashpay/dash.git
cd dash

# Copy Doxygen config / build files
cp $TRAVIS_BUILD_DIR/doxygen/* doc/

################################################################################
##### Generate the Doxygen code documentation and log the output.          #####
echo 'Generating Doxygen code documentation...'
# Redirect both stderr and stdout to the log file AND the console.
./$TRAVIS_BUILD_DIR/doxygen $DOXYFILE 2>&1 | tee doxygen.log

echo 'Done generating Doxygen code documentation...'
#cat doxygen.log

cd doc/doxygen
du -h

## Copy Doxygen files to dash-docs folder
#echo 'Copy Doxygen files to _site...'
#cp -R doc/doxygen $TRAVIS_BUILD_DIR/_site/en/
