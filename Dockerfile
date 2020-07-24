# Generate War
FROM maven:3.6.3-jdk-8-slim AS stage1
WORKDIR /home/app
COPY . /home/app/
RUN mvn -f /home/app/pom.xml clean package
 
#Deploy war on server
FROM tomcat:9.0 AS stage2
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=stage1 /home/app/target/Hello-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8081
CMD ["catalina.sh", "run"]
