FROM nginx:latest
MAINTAINER guilhermemts
#ARG DEBIAN_FRONTEND=noninteractive

# executando atualizacoes nginx
RUN apt-get update && apt-get upgrade -y

# instalando ferramentas para operacao
RUN apt-get install -y \
    vim \
    git \
    curl \
    python \
    vim \
    sudo \
    net-tools

# diretorio home
WORKDIR /home/ 
RUN mkdir teste  
# COPY ./volumes/config/nginx/www/public/index.html /var/www/html/

# removendo arquivos default /var/www/
RUN mkdir -p /var/www/public/

# criando esquema de diretorio nginx
RUN mkdir /etc/nginx/sites-available/ && >/etc/nginx/app.local
RUN mkdir /etc/nginx/sites-enabled/

# criando links simbolicos para os virtuaishosts
RUN ln -s /etc/nginx/sites-available/app.local /etc/nginx/sites-enabled/app.local

# renomeando arquivos default nginx
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.template.conf

# criacao dos certificados ssl
RUN mkdir /etc/nginx/ssl
#RUN >/etc/nginx/ssl/assessments.local.crt
#RUN >/etc/nginx/ssl/assessments.local.key

# expondo porta para acesso ao nginx
EXPOSE 80
EXPOSE 443
