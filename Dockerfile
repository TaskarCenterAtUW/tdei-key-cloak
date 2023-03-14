# Extend the OpenJDK docker image
FROM openjdk:11-jdk-slim as jdk
ARG KEYTOOL_PASSWORD
# Set /opt/jdk as the working directory
WORKDIR /opt/jdk/

RUN mkdir -p /opt/jdk/conf

RUN keytool -genkeypair -storepass $KEYTOOL_PASSWORD -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

FROM quay.io/keycloak/keycloak:19.0.2 as builder

ENV KC_DB=postgres

RUN /opt/keycloak/bin/kc.sh build --db postgres

FROM quay.io/keycloak/keycloak:19.0.2

ARG KC_DB_URL
ARG KC_DB_USERNAME
ARG KC_DB_PASSWORD
ARG KC_DB_SCHEMA
ARG KC_PROXY
ARG KC_PROXY_ADDRESS_FORWARDING
ARG KC_HTTP_ENABLED
ARG KEYCLOAK_ADMIN
ARG KEYCLOAK_ADMIN_PASSWORD

COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY --from=jdk / /opt/keycloak/conf
WORKDIR /opt/keycloak


# change these values to point to a running postgres instance
ENV KC_DB=postgres
ENV KC_DB_URL=$KC_DB_URL
ENV KC_DB_USERNAME=$KC_DB_USERNAME
ENV KC_DB_PASSWORD=$KC_DB_PASSWORD
ENV KC_DB_SCHEMA=$KC_DB_SCHEMA
ENV KC_PROXY=$KC_PROXY
ENV KC_PROXY_ADDRESS_FORWARDING=$KC_PROXY_ADDRESS_FORWARDING
ENV KC_HOSTNAME_STRICT=$KC_HOSTNAME_STRICT
# ENV KC_HOSTNAME=localhost
ENV KC_HTTP_ENABLED=$KC_HTTP_ENABLED
ENV KEYCLOAK_ADMIN=$KEYCLOAK_ADMIN
ENV KEYCLOAK_ADMIN_PASSWORD=$KEYCLOAK_ADMIN_PASSWORD
# ENV KC_HOSTNAME=https://tdei-sample-container.braveplant-ecc45f9c.westus.azurecontainerapps.io
# ENV KC_HTTP_PORT=8080
#EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/bin/kc.sh","start","--db=postgres"]

#--http-port=8080 --hostname-path=https://tdei-keycloak.azurewebsites.net/   --hostname-strict-backchannel=true  
#--http-port=8080 --hostname-url=https://tdei-keycloak.azurewebsites.net --hostname-admin-url=https://tdei-keycloak.azurewebsites.net/admin --hostname-strict-backchannel=true 
#--http-port=8080 --hostname=tdei-keycloak.azurewebsites.net --hostname-strict-backchannel=true