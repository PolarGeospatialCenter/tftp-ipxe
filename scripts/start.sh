#!/bin/sh

: ${IPXE_URL?}

sed "s|IPXE_URL|${IPXE_URL}|g" templates/chain.ipxe > /srv/tftp/chain.ipxe

exec /bin/udpsvd -v -E 0.0.0.0 69 tftpd -r -u nobody /srv/tftp
