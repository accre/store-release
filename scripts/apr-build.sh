#!/usr/bin/env bash
#
#  Builds the APR Apache Portable Runtime  libraries.  Should be run from inside the base directory
#

d=""
[ "${1}" == "32" ] && export CC="gcc -m32" && d="32" && echo "Making 32-bit binaries"

[ "${PREFIX}" == "" ] && PREFIX=/usr/local

#Apply the patch
patch -p1 < ../../tarballs/apr.patch
if [[ $? -ne 0 ]]; then
    grep apr-ACCRE configure >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "Patch failed, but it might've been applied before, ignoring."
    else
        echo "Patch failed"
        exit 1
    fi
fi

./configure --prefix=${PREFIX}${d} --enable-static --enable-shared && \
make $MAKE_ARGS && \
# takes forever
# make $MAKE_ARGS test && \
make $MAKE_ARGS install

