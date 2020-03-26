#! /bin/zsh
#

# phenix setup resets this back to an older version.
source /Applications/dials-v1-14-1/dials_env.sh

# Setting xia2.settings.resolution.misigma=0 xia2.settings.resolution.isigma=0
# This allows resolution limit to be determined by CC half only.
xia2 pipeline=dials /Users/errontitus/Dropbox/calsquestrin-structure-function/data/xtal/native/Plate_16_C2_T2/data xia2.settings.unit_cell='62.555,62.555,213.255,90.000,90.000,90.000' xia2.settings.space_group='P4322' xia2.settings.resolution.misigma=0 xia2.settings.resolution.isigma=0 | tee xia2_dials.log

# IMPORTANT: do this after dials. Otherwise, certain phenix tools will use incompatible dials code.
source /Applications/phenix-1.15.2-3472/phenix_env.sh
