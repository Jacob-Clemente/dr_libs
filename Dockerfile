# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Add source code to the build stage.
ADD . /dr_libs
WORKDIR /dr_libs

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y clang

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN clang -fsanitize=fuzzer tests/flac/fuzz_dr_flac.c -o dr_libs

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /dr_libs/dr_libs /
