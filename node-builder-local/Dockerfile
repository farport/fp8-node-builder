FROM farport/fp8-node-builder:8.14

ARG userId
ARG groupId
ARG FP8USER=fp8user

ADD build/id_git_rsa.key /root/.ssh/
ADD ssh.config /root/.ssh/config

# Create fp8user:fp8group using the provided ids
RUN FP8USER=$(/bin/create_fp8user.sh ${userId} ${groupId}) \
    && USERHOME=$(getent passwd ${FP8USER} | cut -d: -f6) \
    && mkdir $USERHOME/.ssh \
    && cp /root/.ssh/* $USERHOME/.ssh/ \
    && chmod 700 $USERHOME/.ssh \
    && chown -R ${FP8USER} $USERHOME/.ssh/ \
    && chown -R ${FP8USER} /proj \
    && su ${FP8USER} -c 'yarn config set cache-folder /var/cache/yarn'

VOLUME [ "/proj" ]
