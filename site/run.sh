#!/usr/bin/env bash

rm -rf public && hugo server --watch --verbose --buildDrafts
