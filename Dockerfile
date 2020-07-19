FROM jojomi/hugo:0.47 AS build-env

WORkDIR /app
COPY ./site ./

RUN sh -c './build.sh'

# build runtime image
FROM nginx:1.19.1-alpine

COPY ./conf.d/default.conf /etc/nginx/conf.d/

COPY --from=build-env /app/public/ /usr/share/nginx/html
