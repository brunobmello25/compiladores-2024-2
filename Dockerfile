FROM ubuntu:24.04

RUN apt-get update && apt-get install y \
  bison \
  flex

