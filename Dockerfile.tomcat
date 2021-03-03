FROM debian:stable AS builder
RUN apt update && apt install -y \
    build-essential \
    cmake \
    git \
    qtbase5-dev \
    libeigen3-dev \
    libjpeg62-turbo-dev \
    && rm -rf /var/lib/apt/lists/*
# Build relight-cli only.
RUN git clone https://github.com/cnr-isti-vclab/relight.git && \
    cd relight/relight-cli && \
    cmake . && \
    make

# Install runtime dependencies;
# copy relight-cli from builder to runtime.
FROM tomcat:9.0.34-jdk8-openjdk as runtime
RUN apt update && apt install -y \
    libjpeg62-turbo \
    libqt5concurrent5 \
    libqt5gui5 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /relight/relight-cli/relight-cli /usr/local/bin
