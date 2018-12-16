FROM farport/fp8-alpine-node:8.14

ARG userId
ARG groupId
ARG FP8USER=fp8user

# Add the necessary file from host
ADD create_fp8user.sh /bin/
ADD ssh.config /root/.ssh/config
ADD build/id_git_rsa.key /root/.ssh/id_git_rsa.key

# Create fp8user:fp8group using the provided ids
RUN chmod 500 /root/.ssh \
    && chmod 400 /root/.ssh/* \
    && ssh-keyscan gitlab.com > /root/.ssh/known_hosts \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts

# Create the user
RUN FP8USER=$(/bin/create_fp8user.sh ${userId} ${groupId}) \
    && USERHOME=$(getent passwd ${FP8USER} | cut -d: -f6) \
    && mkdir $USERHOME/.ssh \
    && chmod 700 $USERHOME/.ssh \
    && cp /root/.ssh/* $USERHOME/.ssh/ \
    && chown -R ${FP8USER} $USERHOME/.ssh/ \
    && chown -R ${FP8USER} /proj

EXPOSE 8000 8080 8800

VOLUME [ "/proj" ]
