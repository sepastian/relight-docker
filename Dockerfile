FROM debian:stable
RUN apt update && apt install -y \
    build-essential \
    cmake \
    git \
    qtbase5-dev \
    libeigen3-dev \
    libjpeg62-turbo-dev \
    && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/cnr-isti-vclab/relight.git && \
    cd relight/relight-cli && \
    cmake . && \
    make && \
    cp relight-cli /usr/local/bin
