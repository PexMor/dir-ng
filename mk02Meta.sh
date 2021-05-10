#!/bin/bash

function findAtDepth() {
    local ROOT=$1
    local DEPTH=5
    find ${ROOT} -mindepth ${DEPTH} -maxdepth ${DEPTH} -type d | while read DIR; do
        TFN="tmp/work/dir-ng.json"
        # echo $DIR
        if [ ! -f "$DIR/dir-ng.json" ]; then
            python dir-ng.py $DIR $DIR $ROOT > "$TFN"
            # atomic operation !
            mv "$TFN" "$DIR/"
        fi
    done
}

function findAtDepthDirNg() {
    local ROOT=$1
    local DEPTH=6
    find ${ROOT} -mindepth ${DEPTH} -maxdepth ${DEPTH} -name dir-ng.json | while read DIRNG; do
        echo $DIRNG
    done
}

findAtDepth "tmp/old"
findAtDepth "tmp/new"

findAtDepthDirNg "tmp/old" >tmp/work/old-list.txt
findAtDepthDirNg "tmp/new" >tmp/work/new-list.txt

python simpleSha1.py tmp/work/old-list.txt | cut -d/ -f3- >tmp/work/old-meta.txt
# atomic operation !
mv tmp/work/old-meta.txt tmp/old/meta.txt
python simpleSha1.py tmp/work/new-list.txt | cut -d/ -f3- >tmp/work/new-meta.txt
# atomic operation !
mv tmp/work/new-meta.txt tmp/new/meta.txt

diff -u tmp/old/meta.txt tmp/new/meta.txt | tee tmp/meta.diff
