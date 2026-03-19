FROM gcc:12.2.0

# Install cpputest
WORKDIR /opt/cpputest

RUN git clone --depth 1 --branch v4.0 https://github.com/cpputest/cpputest.git .
RUN autoreconf . -i && \
    ./configure && \
    make tdd && \
    make install 

ENV CPPUTEST_HOME=/opt/cpputest

WORKDIR /home/src
