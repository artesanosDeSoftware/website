#!/usr/bin/env bash

VER=$(grep "version" website.properties|cut -d'=' -f2)  && docker build -t artesanos/website:$VER . && docker push artesanos/website:$VER #&& kubectl set image deployment/website website=artesanos/website:$VER'
