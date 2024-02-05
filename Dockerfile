FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /WP-LABS2
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src src
RUN mvn package -DskipTests

FROM openjdk:17
WORKDIR /WP-LABS2
COPY --from=build /WP-LABS2/target/*.jar WP-LABS2.jar
EXPOSE 8080
CMD ["java", "-jar", "WP-LABS2.jar"]
