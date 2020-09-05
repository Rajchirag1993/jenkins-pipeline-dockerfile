FROM ubuntu
MAINTAINER rajesh <raajesh987@gmail.com>
RUN apt-get update -y
RUN mkdir /usr/app/
RUN chmod 777 -R /usr/app/
WORKDIR /usr/app/
COPY gameoflife-build/target/gameoflife-build-1.0-SNAPSHOT.jar /usr/app/
