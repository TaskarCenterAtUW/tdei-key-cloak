# Extend the OpenJDK docker image
FROM openjdk:11-jdk-slim as jdk
ARG KEYTOOL_PASSWORD=testing
# Set /opt/jdk as the working directory
WORKDIR /opt/jdk/

RUN mkdir -p /opt/jdk/conf

RUN keytool -genkeypair -storepass $KEYTOOL_PASSWORD -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

# COPY ms-root.pem /opt/keycloak/data/import/ms-root.pem

# # Import the Microsoft RSA Root Certificate into the Keycloak keystore
# RUN keytool -import -trustcacerts -alias microsoft_rsa_root \
#     -file /opt/keycloak/data/import/ms-root.pem \
#     -storepass $KEYTOOL_PASSWORD \
#     -keystore conf/server.keystore -noprompt

FROM quay.io/keycloak/keycloak:19.0.2 as builder

ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true

RUN /opt/keycloak/bin/kc.sh build --db postgres

FROM quay.io/keycloak/keycloak:19.0.2

ARG KC_DB_URL=
ARG KC_DB_USERNAME=tdeiadmin
ARG KC_DB_PASSWORD=
ARG KC_DB_SCHEMA=keycloak
ARG KC_PROXY=edge
ARG KC_PROXY_ADDRESS_FORWARDING=true
ARG KC_HTTP_ENABLED=true
ARG KEYCLOAK_ADMIN=tdeikeycloakadmin
ARG KEYCLOAK_ADMIN_PASSWORD=

COPY --from=builder /opt/keycloak/ /opt/keycloak/
COPY --from=jdk / /opt/keycloak/conf
WORKDIR /opt/keycloak

COPY tdei-realm.json /opt/keycloak/data/import/tdei-realm.json
# COPY Microsoft_RSA_Root_Certificate_Authority_2017.crt /opt/keycloak/cert/ms-root.cert
# COPY ms-root.pem /opt/keycloak/cert/ms-root.pem
# COPY DigiCertGlobalRootG2.crt.pem /opt/keycloak/cert/dgcert-root.pem
# COPY dcg-root.pem /opt/keycloak/cert/dg-root.pem

# change these values to point to a running postgres instance
# ENV KC_HTTPS_CERTIFICATE_FILE=/opt/keycloak/cert/ms-root.cert
# ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/opt/keycloak/cert/ms-root.pem
# ENV KC_HTTPS_KEY_STORE_FILE=/opt/keycloak/conf/server.keystore
# ENV KC_HTTPS_KEY_STORE_PASSWORD=testing
ENV KC_TRUSTSTORE_PATHS=/opt/keycloak/cert/ms-root.pem
# ENV KC_HTTPS_CLIENT_AUTH=request
ENV KC_DB=postgres
ENV KC_DB_URL=$KC_DB_URL
ENV KC_DB_USERNAME=$KC_DB_USERNAME
ENV KC_DB_PASSWORD=$KC_DB_PASSWORD
ENV KC_DB_SCHEMA=$KC_DB_SCHEMA
ENV KC_PROXY=$KC_PROXY
ENV KC_HTTPS_PROTOCOLS=TLSv1.3,TLSv1.2
ENV KC_PROXY_ADDRESS_FORWARDING=$KC_PROXY_ADDRESS_FORWARDING
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=$KC_HTTP_ENABLED
ENV KEYCLOAK_ADMIN=$KEYCLOAK_ADMIN
ENV KEYCLOAK_ADMIN_PASSWORD=$KEYCLOAK_ADMIN_PASSWORD
ENV KC_HOSTNAME_STRICT_BACKCHANNEL=false
ENTRYPOINT ["/opt/keycloak/bin/kc.sh","start","--import-realm","--optimized","--log-level=ALL"]