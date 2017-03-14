FROM openjdk:7-jdk-alpine
RUN mkdir /opt/ && \
    cd /opt/ && \
    mkdir /opt/gtfs-editor && \
    apk add --update --no-cache python && \
    wget http://downloads.typesafe.com/releases/play-1.2.5.zip && \
    jar xf play-1.2.5.zip && \
    chmod +x /opt/play-1.2.5/play && \
    rm play-1.2.5.zip 
    
WORKDIR /opt/gtfs-editor
ADD . /opt/gtfs-editor
RUN sed s/application.mode=dev/application.mode=prod/g conf/application.conf.template > conf/application.conf && \
    /opt/play-1.2.5/play dependencies --forProd
EXPOSE 9000
VOLUME /opt/gtfs-editor/data
ENV _JAVA_OPTIONS "-Xms256m -Xmx256m"
CMD ["/opt/play-1.2.5/play","run"]
