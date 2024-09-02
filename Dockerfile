# Extend the OpenJDK docker image
FROM openjdk:11-jdk-slim as jdk
ARG KEYTOOL_PASSWORD
# Set /opt/jdk as the working directory
WORKDIR /opt/jdk/

RUN mkdir -p /opt/jdk/conf

RUN keytool -genkeypair -storepass $KEYTOOL_PASSWORD -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

COPY Microsoft_RSA_Root_Certificate_Authority_2017.crt /opt/keycloak/data/import/Microsoft_RSA_Root_Certificate_Authority_2017.crt

# Import the Microsoft RSA Root Certificate into the Keycloak keystore
RUN keytool -import -trustcacerts -alias microsoft_rsa_root \
    -file /opt/keycloak/data/import/Microsoft_RSA_Root_Certificate_Authority_2017.crt \
    -storepass $KEYTOOL_PASSWORD \
    -keystore conf/server.keystore -noprompt

FROM quay.io/keycloak/keycloak:19.0.2 as builder

ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true

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

COPY tdei-realm.json /opt/keycloak/data/import/tdei-realm.json

# change these values to point to a running postgres instance
ENV KC_DB=postgres
ENV KC_DB_URL=$KC_DB_URL
ENV KC_DB_USERNAME=$KC_DB_USERNAME
ENV KC_DB_PASSWORD=$KC_DB_PASSWORD
ENV KC_DB_SCHEMA=$KC_DB_SCHEMA
ENV KC_PROXY=$KC_PROXY
ENV KC_PROXY_ADDRESS_FORWARDING=$KC_PROXY_ADDRESS_FORWARDING
ENV KC_HOSTNAME_STRICT=$KC_HOSTNAME_STRICT
ENV KC_HTTP_ENABLED=$KC_HTTP_ENABLED
ENV KEYCLOAK_ADMIN=$KEYCLOAK_ADMIN
ENV KEYCLOAK_ADMIN_PASSWORD=$KEYCLOAK_ADMIN_PASSWORD
ENTRYPOINT ["/opt/keycloak/bin/kc.sh","start","--import-realm","--optimized"]
