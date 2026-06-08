FROM        docker.io/library/openjdk:21-ea AS builder
WORKDIR     /app
COPY        ./ /app/
RUN         chmod +x ./gradlew && ./gradlew bootJar --no-daemon -x test

FROM        docker.io/library/openjdk:21-ea
#RUN         dnf install java-21-openjdk.x86_64 -y
COPY        --from=builder  /app/build/libs/*.jar portfolio-service.jar
ENTRYPOINT  [ "java", "-jar", "./portfolio-service.jar" ]
