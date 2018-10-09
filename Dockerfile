FROM alpine

RUN apk add --no-cache gcc binutils make perl xz-dev mtools cdrkit syslinux git musl-dev bash openssl coreutils

WORKDIR /usr/local/src/
RUN git clone git://git.ipxe.org/ipxe.git

WORKDIR /usr/local/src/ipxe/src/
COPY ca.crt /certs/ca.crt
COPY embed /embed/
RUN make -j4 bin/undionly.kpxe EMBED=/embed/localchain.ipxe


FROM alpine

RUN apk add --no-cache tftp-hpa
COPY scripts/start.sh /bin/start.sh
COPY templates/ /templates/
RUN chmod a+x /bin/start.sh
COPY --from=0 /usr/local/src/ipxe/src/bin/undionly.kpxe /srv/tftp/undionly.kpxe
CMD /bin/start.sh