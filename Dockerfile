FROM farport/fp8-alpine-node:8.14

ARG GIT_PROJ_URL

# Add the necessary file from host
ADD create_fp8user.sh /bin/
ADD ssh.config /root/.ssh/config
ADD build/id_git_rsa.key /root/.ssh/id_git_rsa.key

# Create fp8user:fp8group using the provided ids
RUN chmod 500 /root/.ssh \
    && chmod 400 /root/.ssh/* \
    && ssh-keyscan gitlab.com > /root/.ssh/known_hosts \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && git clone ${GIT_PROJ_URL} /proj

EXPOSE 8000 8080 8800
