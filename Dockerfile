FROM nginx:alpine as build

RUN apk add --update \
    wget git hugo


COPY myblog /myblog
WORKDIR /myblog

RUN git clone https://github.com/budparr/gohugo-theme-ananke.git themes/ananke

RUN echo 'theme = "ananke"' >> config.toml

RUN hugo

FROM nginx:alpine

COPY --from=build /myblog/public /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
