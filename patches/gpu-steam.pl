#!/usr/bin/perl -pi

# Enable the GPU in hybrid GPU setups
s'Exec=/usr/bin/steam %U'Exec=env DRI_PRIME=1 /usr/bin/steam %U';

