#!/usr/bin/bash

echo "Cleaning paru/pacman cache ..."
paru -Sc
echo "Cleaning npm cache ..."
npm cache clean --force
echo "Cleaning uv cache ..."
uv cache clean
echo "Cleaning pip cache ..."
pip cache purge
echo "Cleaning yarn cache ..."
yarn cache clean
echo "Cleaning ccache ..."
ccache -C
echo "Cleaning go cache ..."
go clean -cache
