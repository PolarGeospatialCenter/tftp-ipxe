FROM alpine as ipxe

RUN apk add --no-cache gcc binutils make perl xz-dev mtools cdrkit syslinux git musl-dev bash openssl coreutils

WORKDIR /usr/local/src/
RUN git clone git://git.ipxe.org/ipxe.git

WORKDIR /usr/local/src/ipxe/src/
COPY embed /embed/
RUN make -j4 bin/undionly.kpxe EMBED=/embed/localchain.ipxe


FROM busybox

COPY scripts/start.sh /bin/start.sh
COPY templates/ /templates/
RUN chmod a+x /bin/start.sh
COPY --from=ipxe /usr/local/src/ipxe/src/bin/undionly.kpxe /srv/tftp/undionly.kpxe
CMD /bin/start.sh
