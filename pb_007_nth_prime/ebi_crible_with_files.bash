#!/bin/bash

IFS=$'\t\n'
LANG=en_GB.UTF-8

STEP=1024
TARGET=$STEP

SCRIPT=$0
SCRIPT_NAME=$(basename $SCRIPT)
SCRIPT_SUFFIX=${SCRIPT_NAME%.*}

OUT_DIR="./out"
mkdir -p $OUT_DIR
OUT_PRIMES=${OUT_DIR}/${SCRIPT_SUFFIX}_primes
OUT_NUM=${OUT_DIR}/${SCRIPT_SUFFIX}_numeric_order
OUT_ALPHA=${OUT_DIR}/${SCRIPT_SUFFIX}_alpha_order


echo_err() {
    >&2 echo $@;
}

set_target_aux() {
    echo "$1 / l($1)" | bc -l | sed "s,\..*,,"
}

set_target() {
    while [[ $(set_target_aux $TARGET) -lt $1 ]] ; do
        TARGET=$((TARGET + STEP));
    done
}

primes() {
    if [[ $1 -lt 1 ]] ; then
        return;
    fi

    for f in $OUT_PRIMES $OUT_NUM $OUT_ALPHA ; do
        rm -rf $f &>/dev/null
    done

    seq 2 $1 > $OUT_NUM
    sort $OUT_NUM > $OUT_ALPHA
    readonly sqrt=$(dc -e "$TARGET vp");
    next_prime=2;
    while [[ $next_prime -lt $sqrt ]] ; do
        echo $next_prime >> $OUT_PRIMES
        comm -13 <(mults $next_prime $TARGET) <(cat $OUT_ALPHA) | sort -n > $OUT_NUM
        sort $OUT_NUM > $OUT_ALPHA
        next_prime=$(sed "1q;d" $OUT_NUM);
    done
    cat $OUT_NUM >> $OUT_PRIMES
}

mults() {
    seq $1 $1 $2 | sort;
}

parse_args() {
    if [[ $# -ne 1 ]] ; then
        echo_err "Exactly one argument is expected (not $#).";
        exit -1;
    fi

    if [[ ! $1 =~ ^[0-9]+$ || $1 -lt 1 ]] ; then
        echo_err "The given argument shall be a positive integer (>1).";
        exit -2;
    fi
}

# Script starts here
parse_args $@

# NTH = $1 if exists, else set NTH to 1.
readonly NTH=${1:-1};
set_target $NTH;

readonly START=$(date +%s%N)
primes $TARGET
readonly RES=$(sed "${NTH}q;d" $OUT_PRIMES)
readonly END=$(date +%s%N)
readonly TIME=$(echo "($END - $START) / 10^6" | bc)

cat <<EOF
Input  : $NTH
Result : $RES
Time   : $TIME ms
EOF

exit 0;
