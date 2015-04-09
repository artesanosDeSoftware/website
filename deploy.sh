#!/usr/bin/env bash

rm -rf software
mkdir software
rm -rf public && hugo --theme=hyde-x --verbose && mv public/* software && mv software public/ && cp foo/index.html public && rsync -avzhe ssh --delete --delete-after ./public deployer@198.58.120.79:/www/artesanos.de
