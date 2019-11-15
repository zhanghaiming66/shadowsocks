FROM alpine:latest
RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.5/main" > /etc/apk/repositories
RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.5/community" >> /etc/apk/repositories
RUN apk update
RUN apk --no-cache add tzdata  && \
   ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
   echo "Asia/Shanghai" > /etc/timezone
RUN apk add python3
RUN pip3 install --upgrade pip
RUN pip3 install shadowsocks
RUN echo '{"server":"0.0.0.0","server_port":8388,"local_address": "127.0.0.1","local_port":1080,"password":"123456","timeout":300,"method":"aes-256-cfb","fast_open": false}' > /etc/shadowsocks.json
RUN sed -i 's/cleanup/reset/' /usr/lib/python3.5/site-packages/shadowsocks/crypto/openssl.py
CMD ["ssserver", "-c", "/etc/shadowsocks.json"]
