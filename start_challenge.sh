#!/bin/bash

echo -n "Set? : "
read set
echo -n "Challenge? : "
read challenge

echo "Setting up directories..."
path=./"set$set"/"challenge$challenge"
mkdir -p $path
cp -r ~/projects/templates/ruby/ $path/






