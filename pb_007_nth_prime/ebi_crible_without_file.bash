#!/bin/bash

IFS=$'\t\n'
LANG=en_GB.UTF-8

STEP=1024
TARGET=$STEP

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
    [[ $1 -gt 1 ]] && comm -23 <(mults 1 $1) <(non_primes $1) | sort -n;
}

mults() {
    seq $((2*$1)) $1 $2 | sort;
}

non_primes() {
    n=$1;
    sqrt=$(dc -e "$n vp");
    for p in $(primes $sqrt); do
        mults $p $n
    done | sort | uniq
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
readonly INDEX=$((NTH -1));
set_target $NTH;

readonly START=$(date +%s%N)
readonly primes_array=($(primes $TARGET))
readonly END=$(date +%s%N)
readonly RES=${primes_array[$INDEX]}
readonly TIME=$(echo "($END - $START) / 10^6" | bc)

cat <<EOF
Input  : $NTH
Result : $RES
Time   : $TIME ms
EOF

exit 0;
