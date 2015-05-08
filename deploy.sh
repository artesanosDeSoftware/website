#!/usr/bin/env bash

rm -rf software
mkdir software
rm -rf public && hugo --verbose && mv public/* software && mv software public/ && cp foo/* public && rsync -avzhe ssh --delete --delete-after ./public deployer@198.58.120.79:/www/artesanos.de
