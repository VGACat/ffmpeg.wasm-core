ARG EM_VERSION=2.0.24

FROM emscripten/emsdk:$EM_VERSION as builder
ENV EM_VERSION=2.0.24
ENV FFMPEG_ST=yes
ENV DIST_PATH=wasm/packages/core-st/dist
ENV CACHE_KEY_PREFIX=ffmpeg.wasm-core-st

WORKDIR /app/
COPY . .

RUN echo "install deps"
RUN bash ./build.sh install-deps

RUN echo "build libs"
RUN bash ./build.sh \
            build-zlib \
            build-x264 \
            build-x265 \
            build-libvpx \
            build-wavpack \
            build-lame \
            build-fdk-aac \
            build-ogg \
            build-vorbis \
            build-theora \
            build-opus \
            build-libwebp \
            build-freetype2 \
            build-fribidi \
            build-harfbuzz \
            build-libass

RUN echo "build ffmpeg"
RUN bash ./build.sh \
            configure-ffmpeg \
            build-ffmpeg

ENTRYPOINT ["ls", "/app/wasm/packages/core-st/dist"]
