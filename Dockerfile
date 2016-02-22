FROM ubuntu:latest
MAINTAINER Werner Schmid

RUN apt-get update && apt-get install -y pdftk wget ssmtp mailutils emacs24-nox imagemagick sam2p bc unoconv poppler-utils zip fdupes texlive-full libreoffice-base
COPY grep.sh /scripts/grep.sh
COPY merge-file-lists.sh /scripts/merge-file-lists.sh
COPY sendmail-attachment.sh /scripts/sendmail-attachment.sh
COPY image-to-pdf.sh /scripts/image-to-pdf.sh
COPY create-watermark.sh /scripts/create-watermark.sh
COPY watermark.tex /scripts/watermark.tex
