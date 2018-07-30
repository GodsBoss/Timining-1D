FROM alpine:3.7 AS builder

# Install necessary software
RUN apk add --update-cache \
  gimp \
  nodejs \
  nodejs-npm
RUN npm install --global coffeescript@2.3.1

WORKDIR /root
COPY Cakefile /root
COPY init.coffee /root
COPY src /root/src
COPY gfx.xcf /root
COPY export.scm /root
COPY build.sh /root

RUN /root/build.sh

FROM nginx:1.15.2-alpine
COPY index.html /usr/share/nginx/html
COPY images /usr/share/nginx/html/images
COPY --from=builder /root/gfx.png /usr/share/nginx/html
COPY --from=builder /root/init.js /usr/share/nginx/html
COPY --from=builder /root/timining.js /usr/share/nginx/html
