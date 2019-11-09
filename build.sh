#!/bin/bash

mkdir -p dist
echo "Build at:" > dist/index.html
date 2>&1 >> dist/index.html