#!/bin/sh

: ${IPXE_URL?}

sed "s|IPXE_URL|${IPXE_URL}|g" templates/chain.ipxe > /srv/tftp/chain.ipxe

exec /usr/sbin/in.tftpd -L -R 4096:32767 -s -vvv /srv/tftp
