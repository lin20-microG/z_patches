#!/bin/bash

THISDIR=$PWD

cd ..
TOPDIR=$PWD

cd vendor/lineage
echo "Patching $PWD (Signing the build)"
patch -p1 < $THISDIR/patch_010_vendor.patch
echo "-"
cd $TOPDIR


cd $THISDIR
