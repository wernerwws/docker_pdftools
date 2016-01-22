FROM ubuntu:latest
MAINTAINER Werner Schmid

RUN apt-get update && apt-get install -y pdftk wget ssmtp mailutils
COPY grep.sh /scripts/grep.sh
