#!/bin/sh

cat export.scm | gimp -i -b -
ls src/*.coffee | xargs coffee -j timining.coffee -c -b
coffee -c init.coffee
