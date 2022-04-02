#!/bin/bash

set -eux

# Set symlinks
# https://github.com/Wireless-Innovation-Forum/Common-Data/blob/master/README.md#data-integration-into-sas
# We expect a Common-Data volume to be mounted at $COMMON_DATA path

if [[ -d "$COMMON_DATA" ]]; then
    ln -s $COMMON_DATA/data/ned /opt/app/src/data/geo/ned
    ln -s $COMMON_DATA/data/nlcd /opt/app/src/data/geo/nlcd
    ln -s $COMMON_DATA/data/counties /opt/app/src/data/counties
else
    echo -e "$(tpud setaf 1)ERR: No Common-Data found at $COMMON_DATA\!"
    exit 1
fi

conda run -n winnf3 python3 $@
