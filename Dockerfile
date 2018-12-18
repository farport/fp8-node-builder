FROM node:8.14.0-alpine

# Add the necessary file from host
ADD bin/* /bin/

# Create fp8user:fp8group using the provided ids
RUN apk update \
    && apk add --no-cache git openssh-client \
    && yarn config set cache-folder /var/cache/yarn \
    && mkdir /root/.ssh \
    && ssh-keyscan gitlab.com > /root/.ssh/known_hosts \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts \
    && chmod 500 /root/.ssh \
    && mkdir /proj

VOLUME [ "/var/cache/yarn" ]