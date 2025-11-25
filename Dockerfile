FROM adoptopenjdk/openjdk11:ppc64le-ubi-minimal-jre-11.0.30_2-ea-beta-nightly
WORKDIR /app
COPY . . 
RUN sudo chmod +x gradlew
RUN ./gradlew build 

FROM tomcat:9
WORKDIR webapps
COPY --from=base /app/build/libs/myapp.war .
RUN rm -rf ROOT && mv myapp.war ROOT.war 
EXPOSE 8080
CMD ["catalina.sh", "run"]
