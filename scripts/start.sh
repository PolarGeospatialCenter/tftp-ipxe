#!/bin/sh

: ${IPXE_URL?}

sed "s|IPXE_URL|${IPXE_URL}|g" templates/chain.ipxe > /srv/tftp/chain.ipxe

exec /usr/sbin/in.tftpd -s /srv/tftp --verbose --blocksize 1024 --foreground
