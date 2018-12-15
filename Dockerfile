FROM farport/fp8-alpine-node:8.14

ARG userId
ARG groupId
ARG FP8USER=fp8user

# Add the necessary file from host
ADD create_fp8user.sh /bin/
ADD ssh.config /data/ssh/config
ADD build/id_git_rsa.key /data/ssh/id_git_rsa.key

# Create fp8user:fp8group using the provided ids
RUN FP8USER=$(/bin/create_fp8user.sh ${userId} ${groupId}) \
    && mkdir /output \
    && chown -R ${FP8USER} /output \
    && chown -R ${FP8USER} /data \
    && mkdir -p /home/${FP8USER}/.ssh \
    && cp /data/ssh/* /home/${FP8USER}/.ssh/ \
    && ssh-keyscan gitlab.com > /home/${FP8USER}/.ssh/known_hosts \
    && ssh-keyscan github.com >> /home/${FP8USER}/.ssh/known_hosts \
    && chown -R ${FP8USER} /home/$FP8USER/ \
    && chmod 400 /home/${FP8USER}/.ssh/config

EXPOSE 8000 8080 8100 8200 8300 8400 8500 8600 8700 8800 8900

VOLUME [ "/output", "/data" ]
