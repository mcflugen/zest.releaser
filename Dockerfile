FROM python:3.8
WORKDIR /zest.releaser/
ENV PYTHONPATH=/zest.releaser/
ENV USER=root
ENV HGUSER=root
RUN pip install -U pip setuptools && \
    apt-get update && \
    apt-get -y install git \
                       subversion \
                       bzr \
                       mercurial \
                       git-svn
RUN git config --global user.name "Temp user" && \
    git config --global user.email "temp@example.com" && \
    bzr whoami "Temp user <temp@example.com>"
COPY . /zest.releaser/
RUN python bootstrap.py && \
    bin/buildout
CMD bin/test -v
