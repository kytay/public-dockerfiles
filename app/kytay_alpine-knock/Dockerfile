FROM alpine:3

RUN apk update && \
apk add curl bash

COPY ./knock-array.sh /

RUN curl -LO https://github.com/BentonEdmondson/knock/releases/download/1.3.1/knock-1.3.1-x86_64-linux && \
chmod +x ./knock-1.3.1-x86_64-linux && \
mv ./knock-1.3.1-x86_64-linux /usr/bin/knock && \
chmod +x /knock-array.sh

ENTRYPOINT ["/knock-array.sh"]
CMD ["/bin/bash"]