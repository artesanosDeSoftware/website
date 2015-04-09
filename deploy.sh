#!/usr/bin/env bash

rm -rf public && hugo --theme=hyde-x --verbose && rsync -avzhe ssh --delete --delete-after ./public deployer@198.58.120.79:/www/artesanos.de
