# Extend the OpenJDK docker image
FROM openjdk:11-jdk-slim as jdk

# Set /opt/jdk as the working directory
WORKDIR /opt/jdk/

RUN mkdir -p /opt/jdk/conf

RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

FROM quay.io/keycloak/keycloak:19.0.2 as builder

ENV KC_DB=postgres

RUN /opt/keycloak/bin/kc.sh build --db postgres

FROM quay.io/keycloak/keycloak:19.0.2
COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY --from=jdk / /opt/keycloak/conf
WORKDIR /opt/keycloak


# change these values to point to a running postgres instance
ENV KC_DB_URL="jdbc:postgresql://tdei.postgres.database.azure.com:5432/tdei"
ENV KC_DB_USERNAME=tdeiadmin
ENV KC_DB_PASSWORD=Admin01*
ENV KC_DB_SCHEMA=keycloak
ENV KC_PROXY=edge
ENV KC_PROXY_ADDRESS_FORWARDING=true
ENV KC_HOSTNAME_STRICT=false
# ENV KC_HOSTNAME=localhost
ENV KC_HTTP_ENABLED=true
ENV KEYCLOAK_ADMIN=tdei
ENV KEYCLOAK_ADMIN_PASSWORD=Admin01*
# ENV KC_HOSTNAME=https://tdei-sample-container.braveplant-ecc45f9c.westus.azurecontainerapps.io
# ENV KC_HTTP_PORT=8080
# EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/bin/kc.sh","start","--db=postgres"]

#--http-port=8080 --hostname-path=https://tdei-keycloak.azurewebsites.net/   --hostname-strict-backchannel=true  
#--http-port=8080 --hostname-url=https://tdei-keycloak.azurewebsites.net --hostname-admin-url=https://tdei-keycloak.azurewebsites.net/admin --hostname-strict-backchannel=true 
#--http-port=8080 --hostname=tdei-keycloak.azurewebsites.net --hostname-strict-backchannel=true 