#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q themix-gui-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/com.github.themix_project.Oomox.svg/com.github.themix_project.Oomox.svg
export DESKTOP=/usr/share/applications/com.github.themix_project.Oomox.desktop
export DEPLOY_PYTHON=1
export ALWAYS_SOFTWARE=1

# Deploy dependencies
quick-sharun \
	/usr/bin/oomox*  \
	/usr/bin/themix* \
	/usr/lib/libgtk-3.so*

sed -i -e 's|/opt/oomox|"$APPDIR"/bin|' ./AppDir/bin/oomox* ./AppDir/bin/themix*
cp -rv /opt/oomox/* ./AppDir/bin

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
