#!/bin/bash

if [ "x$(uname -s)" = "xDarwin" ]; then
    echo "MacOSX gnu-tools fix" >&2
    GREP=ggrep
    FIND=gfind
    SED=gsed
    READLINK=greadlink
    SAY=say
    DATE=gdate
else
    GREP=grep
    FIND=find
    SED=sed
    READLINK=readlink
    DATE=date
fi
export GREP FIND SED READLINK SAY DATE

function mk1dir() {
    local DIR=$1
    SN=`echo -n "$DIR" | sed "s#\./##g"`
    NA=`echo -n "$SN" | tr "/" "-"`
    # echo "$SN $DIR $NA"
    FDIR="$DIR/$NA"
    DORANDOM=${RANDOM}
    if [[ $DORANDOM -lt $PCT2RANDOM ]]; then
        echo "[R] $FDIR"
        RCNT=$[RCNT+1]
        [ -d "$FDIR" ] || mkdir -p "$FDIR"
        echo "Semi random ${RANDOM}: $FDIR" >"$FDIR/random.txt"
        EXTRA="dir-${RANDOM}"
        [ -d "$FDIR/$EXTRA" ] || mkdir -p "$FDIR/$EXTRA"
        echo "Semi random ${RANDOM}: $FDIR" >"$FDIR/$EXTRA/random.txt"
    else
        echo "[S] $FDIR"
        SCNT=$[SCNT+1]
        [ -d "$FDIR" ] || mkdir -p "$FDIR"
        echo "Static content: $FDIR" >"$FDIR/static.txt"
    fi
    echo "RCNT=$RCNT,SCNT=$SCNT" >$ABASE/cnt.txt
}

function mkFdir() {
    local ROOT=$1
    local DEPTH=4
    ABASE=`$READLINK -f "$BASE"`
    PCT2RANDOM=$[60*32768/100]
    RCNT=0
    SCNT=0
    pushd "${ROOT}" >/dev/null
    find . -mindepth ${DEPTH} -maxdepth ${DEPTH} -type d | while read DIR; do
        mk1dir "$DIR"
    done
    popd >/dev/null
    echo "PCT2RANDOM=$PCT2RANDOM"
    cat $ABASE/cnt.txt
}

function alter() {
    local ROOT=$1
    local DEPTH=4
    local DEPTH_P1=$[DEPTH+1]
    ABASE=`$READLINK -f "$BASE"`
    # percentage to remove directory
    PCT_RD2RANDOM=$[5*32768/100]
    # percentage to remove file
    PCT_RF2RANDOM=$[6*32768/100]
    # percentage to modify file
    PCT_MF2RANDOM=$[7*32768/100]
    # percentage to add file
    PCT_AF2RANDOM=$[8*32768/100]
    RDCNT=0
    RFCNT=0
    MFCNT=0
    AFCNT=0
    ADCNT=0
    pushd "${ROOT}" >/dev/null
    # remove random folders
    find . -mindepth ${DEPTH} -type d | sort > "$ABASE/rd_pre.txt"
    find . -mindepth ${DEPTH} -maxdepth ${DEPTH} -type d | while read DIR; do
        SN=`echo -n "$DIR" | sed "s#\./##g"`
        NA=`echo -n "$SN" | tr "/" "-"`
        # echo "$SN $DIR $NA"
        FDIR="$DIR/$NA"
        DORANDOM=${RANDOM}
        if [[ $DORANDOM -lt $PCT_RD2RANDOM ]]; then
            echo "[RD] $FDIR"
            RDCNT=$[RDCNT+1]
            rm -rf "$FDIR"
        fi
        echo "RDCNT=$RDCNT" >$ABASE/rdcnt.txt
    done
    find . -mindepth ${DEPTH} -type d | sort > "$ABASE/rd_post.txt"
    # remove randomly files
    find . -mindepth ${DEPTH_P1} -type f | sort > "$ABASE/rf_pre.txt"
    find . -mindepth ${DEPTH_P1} -type f | while read FN; do
        DORANDOM=${RANDOM}
        if [[ $DORANDOM -lt $PCT_RF2RANDOM ]]; then
            echo "[RF] $FN"
            RFCNT=$[RFCNT+1]
            rm -f "$FN"
        fi
        echo "RFCNT=$RFCNT" >$ABASE/rfcnt.txt
    done
    find . -mindepth ${DEPTH_P1} -type f | sort > "$ABASE/rf_post.txt"
    # modify randomly files
    find . -mindepth ${DEPTH_P1} -type f | sort > "$ABASE/mf_pre.txt"
    find . -mindepth ${DEPTH_P1} -type f | while read FN; do
        DORANDOM=${RANDOM}
        if [[ $DORANDOM -lt $PCT_MF2RANDOM ]]; then
            echo "[MF] $FN"
            MFCNT=$[MFCNT+1]
            date >"$FN"
        fi
        echo "MFCNT=$MFCNT" >$ABASE/mfcnt.txt
    done
    find . -mindepth ${DEPTH_P1} -type f | sort > "$ABASE/mf_post.txt"
    # add randomly files
    find . -mindepth ${DEPTH_P1} -type d | sort > "$ABASE/af_pre.txt"
    find . -mindepth ${DEPTH_P1} -type d | while read DIR; do
        DORANDOM=${RANDOM}
        if [[ $DORANDOM -lt $PCT_AF2RANDOM ]]; then
            NF="$DIR/add-${RANDOM}.txt"
            echo "[AF] $NF"
            AFCNT=$[AFCNT+1]
            date >"$NF"
        fi
        echo "AFCNT=$AFCNT" >$ABASE/afcnt.txt
    done
    find . -mindepth ${DEPTH_P1} -type f | sort > "$ABASE/af_post.txt"
    for ND in ./{pot2,pot3}/2021/{05,06}/{11,12}; do
        echo "[AD] $ND"
        ADCNT=$[ADCNT+1]
        mk1dir "${ND}"
        echo "ADCNT=$ADCNT" >$ABASE/adcnt.txt
    done
    popd >/dev/null
    echo "PCT2RANDOM=$PCT2RANDOM"
    cat $ABASE/rdcnt.txt
    cat $ABASE/rfcnt.txt
    cat $ABASE/mfcnt.txt
    cat $ABASE/afcnt.txt
    cat $ABASE/adcnt.txt
    cat $ABASE/cnt.txt
}

BASE=tmp/test
# clean-up the testing folders
rm -rf $BASE

# Create some dummy folder structure - for poor man's verifiable copy
# old  ~ an old tree which we wanna update
#        (aka local copy)
# new  ~ a new tree which has some modifications
#        (some files created some removed)
#        (aka remote copy - server we are replicating)
# work ~ a working area
#        (for this demo local)
mkdir -p $BASE/{old,new,work}

# make some structure
mkdir -p $BASE/old/{pot1,pot2}/{2020,2021}/{01,02}/{20,21}
mkFdir "$BASE/old"

# replicate it
mkdir -p "$BASE/new"
cp -pr "$BASE/old/." "$BASE/new/"
alter "$BASE/new"

ABASE=`$READLINK -f "$PWD/$BASE"`

pushd "$BASE/old" >/dev/null
find . -mindepth 4 -type f | sort > "$ABASE/old_f.txt"
find . -mindepth 4 -type d | sort > "$ABASE/old_d.txt"
popd
pushd "$BASE/new" >/dev/null
find . -mindepth 4 -type f | sort > "$ABASE/new_f.txt"
find . -mindepth 4 -type d | sort > "$ABASE/new_d.txt"
popd

echo "Diff direcotories/folders:"
diff -u "$BASE/old_d.txt" "$BASE/new_d.txt" | tail -n+4 | $GREP -P "^[\-\+]"
echo
echo "Diff files:"
diff -u "$BASE/old_f.txt" "$BASE/new_f.txt" | tail -n+4 | $GREP -P "^[\-\+]"
