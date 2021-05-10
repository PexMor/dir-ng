#!/bin/bash

mkdir -p tmp/{old,new,work}

mkdir -p tmp/old/{pot1,pot2}/{2020,2021}/{01,02,03}/{20,21,22,30}
mkdir -p tmp/new/{pot1,pot2}/{2019,2021}/{02,03,05}/{22,29,30,31}

function mkFdir() {
    local ROOT=$1
    local DEPTH=4
    find ${ROOT} -mindepth ${DEPTH} -maxdepth ${DEPTH} -type d | while read DIR; do
        SN=`echo -n "$DIR" | sed "s#${ROOT}/##g"`
        NA=`echo -n "$SN" | tr "/" "-"`
        echo "$SN $DIR $NA"
        FDIR="$DIR/$NA"
        [ -d "$FDIR" ] || mkdir -p "$FDIR"
        echo "Semi random ${RANDOM}: $FDIR" >"$FDIR/random.txt"
        EXTRA="dir-${RANDOM}"
        [ -d "$FDIR/$EXTRA" ] || mkdir -p "$FDIR/$EXTRA"
        echo "Semi random ${RANDOM}: $FDIR" >"$FDIR/$EXTRA/random.txt"
    done
}

mkFdir "tmp/old"
mkFdir "tmp/new"
