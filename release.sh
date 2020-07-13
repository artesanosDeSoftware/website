#!/usr/bin/env bash

VER=$(grep "version" website.properties|cut -d'=' -f2)  && \
  docker build -t artesanos/website:$VER \
    -t registry.circulosiete.com/library/artesanos/website:$VER . && \
  #git release $VER && \
  #docker push artesanos/website:$VER && \
  #docker push registry.circulosiete.com/library/artesanos/website:$VER && \
  echo "Done"
