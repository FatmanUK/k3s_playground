#!/bin/bash
set -euxo pipefail

# /dev/urandom is guaranteed to return at least one byte
# but can't guarantee more. By getting one at a time we
# guarantee to get our full 4K.
dd bs=1 count=$1 if=/dev/urandom of=/var/lib/random-seed

rm /etc/ssh/ssh_host_ecdsa_key
rm /etc/ssh/ssh_host_dsa_key
rm /etc/ssh/ssh_host_ed25519_key
rm /etc/ssh/ssh_host_rsa_key

if [ -x /bin/sv ]; then
    sv restart sshd
else
    systemctl restart sshd
fi
