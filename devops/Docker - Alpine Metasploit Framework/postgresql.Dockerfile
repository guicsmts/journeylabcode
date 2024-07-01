FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
MAINTAINER guicsmts

# update ubunto
RUN apt-get update && apt-get upgrade -y

# install adicional package
RUN apt-get install apt sudo wget vim net-tools curl git ssh postgresql -y

# 
EXPOSE 4752
EXPOSE 80