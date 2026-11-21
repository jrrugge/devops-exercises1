#Build phase: reason precomplie the app to keep the final image lean  
FROM maven:3.9.6-eclipse-temurin-21-jammy AS builder
WORKDIR /build

COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .

#dependencies download
RUN ./mvnw dependency:go-offline -B

COPY src ./src
RUN ./mvnw clean package -DskipTests

#Run time phase: JRE lightweight runner 
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

RUN apt-get update && apt-get install -y wget

RUN groupadd -r devops && useradd -r -g devops devops

COPY --from=builder /build/target/*.jar app.jar

#Adjust ownership to the non-root user
RUN chown -R devops:devops /app
USER devops

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
