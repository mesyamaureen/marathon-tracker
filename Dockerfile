#
# Build stage
#
FROM gradle:jdk17-jammy AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon -x test

LABEL org.name="MesyaJeynie"
#
# Package stage
#
FROM eclipse-temurin:17-jdk-jammy
COPY --from=build /home/gradle/src/build/libs/marathon-tracker-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]