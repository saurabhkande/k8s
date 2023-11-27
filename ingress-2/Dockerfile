FROM nginx:latest

COPY default.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /usr/share/nginx/html/path1
RUN mkdir -p /usr/share/nginx/html/path2

COPY path1/index.html /usr/share/nginx/html/path1/index.html
COPY path2/index.html /usr/share/nginx/html/path2/index.html

EXPOSE 80
