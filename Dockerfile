FROM ubuntu
MAINTAINER rajesh <raajesh987@gmail.com>
RUN apt-get update -y
COPY gameoflife-build/target/gameoflife-build-1.0-SNAPSHOT.jar /tmp
