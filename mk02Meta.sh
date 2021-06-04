#!/bin/bash

BASE="tmp/test"
DIR_NG_FN="README.json"

find "$BASE" -name $DIR_NG_FN -exec rm {} \;

function findAtDepth() {
    local ROOT=$1
    local DEPTH=5
    # ROOT_M1="${ROOT%/*}"
    # REL_NAME=`basename "$ROOT"`
    find ${ROOT} -mindepth ${DEPTH} -maxdepth ${DEPTH} -type d | while read DIR; do
        TFN="$BASE/work/$DIR_NG_FN"
        # echo $DIR
        REL_NAME=`basename "$DIR"`
        if [ ! -f "$DIR/$DIR_NG_FN" ]; then
            # python dir-ng.py $DIR $DIR $ROOT $DIR_NG_FN $REL_NAME> "$TFN"
            python dir-ng.py \
                --self-fn $DIR_NG_FN \
                --wrap-fn "wrap-example.json" \
                $DIR > "$TFN"
            # atomic operation !
            mv "$TFN" "$DIR/"
        fi
    done
}

function findAtDepthDirNg() {
    local ROOT=$1
    local DEPTH=6
    find ${ROOT} -mindepth ${DEPTH} -maxdepth ${DEPTH} -name $DIR_NG_FN | while read DIRNG; do
        echo $DIRNG
    done
}

findAtDepth "$BASE/old"
findAtDepth "$BASE/new"

findAtDepthDirNg "$BASE/old" >$BASE/work/old-list.txt
findAtDepthDirNg "$BASE/new" >$BASE/work/new-list.txt

python simpleSha1.py $BASE/work/old-list.txt | cut -d/ -f4- | sort >$BASE/work/old-meta.txt
# atomic operation !
mv $BASE/work/old-meta.txt $BASE/old/meta.txt
python simpleSha1.py $BASE/work/new-list.txt | cut -d/ -f4- | sort >$BASE/work/new-meta.txt
# atomic operation !
mv $BASE/work/new-meta.txt $BASE/new/meta.txt

# get the difference in metadata^2 (list of metadata files ~ README.json with its HASH)
diff -u $BASE/old/meta.txt $BASE/new/meta.txt | tee $BASE/work/meta.diff

# what was removed or added
tail -n+4 $BASE/work/meta.diff | grep "^-" | cut -c2- >$BASE/work/old-rem.txt
tail -n+4 $BASE/work/meta.diff | grep "^+" | cut -c2- >$BASE/work/new-add.txt

#echo "# what was not removed"
#diff -u $BASE/old/meta.txt $BASE/work/old-rem.txt | \
#    tail -n+4 | grep -v "^-" | \
#    tee $BASE/work/old-keep.txt
# diff -u $BASE/new/meta.txt $BASE/work/new-add.txt | tee $BASE/work/new-keep.txt
