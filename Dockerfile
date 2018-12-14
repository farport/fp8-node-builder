FROM farport/fp8-alpine-node:8.14

ADD ssh.config /root/.ssh/config
ADD build/id_git_rsa.key /root/.ssh/

RUN chmod 400 /root/.ssh/* \
    && ssh-keyscan gitlab.com > /root/.ssh/known_hosts \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts

EXPOSE 8000 8080 8100 8200 8300 8400 8500 8600 8700 8800 8900
