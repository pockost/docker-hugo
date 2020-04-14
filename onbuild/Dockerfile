ARG BASE_IMAGE="alpine:latest"

FROM ${BASE_IMAGE}

LABEL description=${DESCRIPTION}
LABEL maintainer="Romain THERRAT <romain@pockost.com>"

ARG VCS_URL="https://github.com/pockost/docker-hugo"
ARG DESCRIPTION="Docker image for building or serving static website with the Hugo static site generator."
ONBUILD ARG HUGO_TYPE=_extended
ONBUILD ARG IMAGE_NAME
ONBUILD ARG VCS_REF
ONBUILD ARG VERSION
ONBUILD ARG BUILD_DATE

ONBUILD ARG HUGO_ID=hugo${HUGO_TYPE}_${VERSION}

RUN apk add --update git asciidoctor libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates

ONBUILD ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${HUGO_ID}_Linux-64bit.tar.gz /tmp
ONBUILD RUN tar -xf /tmp/${HUGO_ID}_Linux-64bit.tar.gz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
    && rm -rf /tmp/${HUGO_ID}_Linux-64bit.tar.gz \
    && rm -rf /tmp/LICENSE.md \
    && rm -rf /tmp/README.md

# Add image labels (https://microbadger.com/labels)
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="POCKOST" \
      org.label-schema.vcs-url=${VCS_URL} \
      org.label-schema.name="${IMAGE_NAME}" \
      org.label-schema.description="${DESCRIPTION}" \
      org.label-schema.url="https://www.pockost.com/" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref=${VCS_REF}

ONBUILD LABEL org.label-schema.version="${VERSION}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-ref=${VCS_REF}

WORKDIR /src

EXPOSE 1313

CMD /usr/local/sbin/hugo serve --bind="0.0.0.0"
