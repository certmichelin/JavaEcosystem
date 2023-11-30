FROM debian
LABEL maintainer='Maxime Escourbiac <maxime.escourbiac_ext@michelin.com>'

#Install prerequisites
RUN apt update
RUN apt dist-upgrade -y
RUN apt install wget unzip -y

#Install tools.
RUN mkdir /tools
WORKDIR /tools
RUN wget https://github.com/frohoff/ysoserial/releases/download/v0.0.6/ysoserial-all.jar -O ysoserial.jar
RUN wget https://github.com/qtc-de/beanshooter/releases/download/v4.1.0/beanshooter-4.1.0-jar-with-dependencies.jar -O beanshooter.jar
COPY marshalsec-0.0.3-SNAPSHOT-all.jar ./marshalsec.jar

RUN mkdir /jdk
WORKDIR /jdk

#Instal Oracle JDK6
COPY jdk-6u45-linux-x64.bin ./
RUN chmod +x jdk-6u45-linux-x64.bin
RUN ./jdk-6u45-linux-x64.bin
RUN rm jdk-6u45-linux-x64.bin
RUN ln -s /jdk/jdk1.6.0_45/bin/java /usr/bin/java6

#Instal Oracle JDK7
COPY jdk-7u80-linux-x64.tar.gz ./
RUN tar xvf jdk-7u80-linux-x64.tar.gz
RUN rm jdk-7u80-linux-x64.tar.gz
RUN ln -s /jdk/jdk1.7.0_80/bin/java /usr/bin/java7

#Instal Oracle JDK8
COPY jdk-8u121-linux-x64.tar.gz ./
RUN tar xvf jdk-8u121-linux-x64.tar.gz
RUN rm jdk-8u121-linux-x64.tar.gz
RUN ln -s /jdk/jdk1.8.0_121/bin/java /usr/bin/java8

#Instal Oracle JDK11
COPY jdk-11.0.19_linux-x64_bin.tar.gz ./
RUN tar xvf jdk-11.0.19_linux-x64_bin.tar.gz
RUN rm jdk-11.0.19_linux-x64_bin.tar.gz
RUN ln -s /jdk/jdk-11.0.19/bin/java /usr/bin/java11

#Instal Oracle JDK17
COPY jdk-17.0.8_linux-x64_bin.tar.gz ./
RUN tar xvf jdk-17.0.8_linux-x64_bin.tar.gz
RUN rm jdk-17.0.8_linux-x64_bin.tar.gz
RUN ln -s /jdk/jdk-17.0.8/bin/java /usr/bin/java17

#Install IBM JDK8
COPY ibm-java-sdk-8.0-8.zip ./
RUN unzip ibm-java-sdk-8.0-8.zip
RUN rm ibm-java-sdk-8.0-8.zip
RUN ln -s /jdk/ibm-java-sdk-8.0-8/jre/bin/java /usr/bin/java8ibm
RUN chmod +x /jdk/ibm-java-sdk-8.0-8/jre/bin/*

WORKDIR /