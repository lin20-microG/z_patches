#!/bin/bash

list_repos() {
cat <<EOF
art:patch_700_art.patch
external/conscrypt:patch_701_conscrypt.patch
frameworks/ex:patch_702_frameworks-ex.patch
packages/apps/Nfc:patch_704_Nfc.patch
packages/modules/Uwb:patch_705_Uwb.patch
EOF
}


THISDIR=$PWD

cd ..
TOPDIR=$PWD

cd device/common
echo "Patching $PWD (Harden location config)"
patch -p1 < $THISDIR/patch_050_device-common.patch
echo "-"
cd $TOPDIR

cd hardware/qcom/gps
echo "Patching $PWD (Harden location config)"
patch -p1 < $THISDIR/patch_051_hardware-qcom-gps.patch
echo "-"
cd $TOPDIR

cd packages/apps/CarrierConfig
echo "Patching $PWD (lift Carrier restrictions)"
patch -p1 < $THISDIR/patch_090_CarrierConfig.patch
echo "-"
cd $TOPDIR

cd packages/apps/DeskClock
echo "Patching $PWD (block alarm-off from other apps)"
patch -p1 < $THISDIR/patch_108_DeskClock.patch
echo "-"
cd $TOPDIR

cd packages/apps/Dialer
echo "Patching $PWD (Remove Google forward lookup)"
patch -p1 < $THISDIR/patch_105_Dialer.patch
echo "-"
cd $TOPDIR

cd external/openssh
echo "Patching $PWD (hmalloc)"
patch -p1 < $THISDIR/patch_100_openssh.patch
echo "-"
cd $TOPDIR

cd frameworks/opt/net/wifi
echo "Patching $PWD (Randomize MAC)"
patch -p1 < $THISDIR/patch_101_frameworks-opt-net-wifi.patch
echo "-"
cd $TOPDIR

cd packages/apps/SetupWizard
echo "Patching $PWD (Remove analytics)"
patch -p1 < $THISDIR/patch_102_SetupWizard.patch
echo "-"
cd $TOPDIR

cd packages/modules/NetworkStack
echo "Patching $PWD (pad filenames to 32 bytes)"
patch -p1 < $THISDIR/patch_103_NetworkStack.patch
echo "-"
cd $TOPDIR

cd system/ca-certificates/files
echo "Patching $PWD (remove untrusted certs)"
rm -fv cb156124.0  #E-Turga
echo "-"
cd $TOPDIR


cd system/extras
echo "Patching $PWD (pad filenames to 32 bytes)"
patch -p1 < $THISDIR/patch_104_extras.patch
echo "-"
cd $TOPDIR

cd packages/modules/common
echo "Patching $PWD (allowed APEXes)"
patch -p1 < $THISDIR/patch_106_modules-common.patch
echo "-"
cd $TOPDIR

cd packages/apps/ImsServiceEntitlement
echo "Patching $PWD (delay FCM registration)"
patch -p1 < $THISDIR/patch_107_ImsServiceEnt.patch
echo "-"
cd $TOPDIR


list_repos | while read STR; do
  DIR=$(echo $STR | cut -f1 -d:)
  PTC=$(echo $STR | cut -f2 -d:)
  cd $DIR
  echo "Constify JNI method tables: $DIR"
  patch -p1 < $THISDIR/$PTC
  cd $TOPDIR
done


cd $THISDIR
