#!/bin/sh

cp index.html dist
cp -r images dist

cat export.scm | gimp -i -b -
ls src/*.coffee | xargs coffee -j timining.coffee -c -b -o dist/timining.js
coffee -o dist/init.js -c init.coffee
