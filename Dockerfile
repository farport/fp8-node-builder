FROM node:10.15.3-alpine

LABEL maintainer="Marcos Lin <marcos.lin@farport.co>" \
	"app.fp8.docker.version.node"="10.15.3" \
	"app.fp8.docker.version.yarn"="1.13.0"

# Add the necessary file from host
ADD bin/* /bin/

# Create fp8user:fp8group using the provided ids
RUN apk update \
    && apk add --no-cache git openssh-client \
    && apk add --no-cache openssl ca-certificates wget \
    && apk add --no-cache g++ gcc libgcc libstdc++ linux-headers make python \
    && yarn config set cache-folder /var/cache/yarn \
    && mkdir /root/.ssh \
    && ssh-keyscan gitlab.com > /root/.ssh/known_hosts \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts \
    && chmod 500 /root/.ssh \
    && mkdir /proj

VOLUME [ "/var/cache/yarn" ]
