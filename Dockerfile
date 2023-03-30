FROM python:3.8-slim-buster

RUN mkdir /pdf && chmod 777 /pdf

WORKDIR /pdf

COPY dockerImage.txt dockerImage.txt

RUN pip install --upgrade pip && pip install -r dockerImage.txt 

RUN apt update && apt install -y ocrmypdf
RUN apt install -y wkhtmltopdf

# add mongo dependencies
RUN apt-get install -y mongodb

#add unoconv to support WORD to PDF conversion locally
RUN apt-get install -y unoconv
#fix a bug where unoconv doesn't recognize Libreoffice
RUN sed -i 's|#!/usr/bin/env python3|#!/usr/bin/python3|' /usr/bin/unoconv

COPY . .

CMD python3 pdf.py