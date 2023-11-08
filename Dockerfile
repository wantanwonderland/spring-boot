# Maven build container 

FROM maven:3.8.5-openjdk-11 AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package

#pull base image

FROM eclipse-temurin:11

#expose port 8080
EXPOSE 8080

#default command
# CMD java -Xms512m -Xmx1024m -jar /data/hello-world-0.1.0.jar
# CMD java ${JAVA_OPTS} -jar /data/hello-world-0.1.0.jar

#copy hello world to docker image from builder image

COPY --from=maven_build /tmp/target/hello-world-0.1.0.jar /data/hello-world-0.1.0.jar

# Entrypoint command
ENTRYPOINT ["sh", "-c", "java -Xms512m -Xmx4000m -jar /data/hello-world-0.1.0.jar"]
#ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /data/hello-world-0.1.0.jar"]