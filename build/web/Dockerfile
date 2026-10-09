# Upstream's Dockerfile (XBEN-009-24/vulnerable-app/Dockerfile) with these changes:
# - the sources are copied from app/vulnerable-app/ (the vendored benchmark folder sits in app/)
# - the build argument FLAG defaults to this lab's fixed flag, the value upstream's Makefile passes
#   (FLAG{sha256 of "XBEN-009-24"}), since the spec passes no build arguments
# - on a Debian buster or bullseye base, apt reads archive.debian.org: both releases have left (or
#   are leaving) the Debian mirrors, so upstream's apt-get install fails there
FROM python:3.9-slim
RUN . /etc/os-release && case "$VERSION_CODENAME" in \
      buster) sec=buster/updates ;; bullseye) sec=bullseye-security ;; *) sec= ;; esac \
 && if [ -n "$sec" ]; then \
      printf 'deb http://archive.debian.org/debian %s main\ndeb http://archive.debian.org/debian-security %s main\n' \
        "$VERSION_CODENAME" "$sec" > /etc/apt/sources.list && rm -f /etc/apt/sources.list.d/*; fi

WORKDIR /app

COPY app/vulnerable-app/requirements.txt /app
RUN pip install -r requirements.txt

COPY app/vulnerable-app/ /app

RUN apt-get update -y

RUN apt-get install -y curl

ARG FLAG=FLAG{0d6abf1498911210d8a8ee29c20b5115e048723e08d8e07aa325a0799f9706a1}
RUN echo -n $FLAG > /flag.txt

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
