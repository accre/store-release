#!/usr/bin/env bash
#
#  Builds the APR Apache Portable Runtime  libraries.  Should be run from inside the base directory
#

d=""
[ "${1}" == "32" ] && export CC="gcc -m32" && d="32" && echo "Making 32-bit binaries"

[ "${PREFIX}" == "" ] && PREFIX=/usr/local

./configure --prefix=${PREFIX}${d} --enable-static --enable-shared
make $MAKE_ARGS
make $MAKE_ARGS test
make $MAKE_ARGS install

