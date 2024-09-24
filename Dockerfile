# Extend the Keycloak image
FROM quay.io/keycloak/keycloak:19.0.2

# Set the working directory
WORKDIR /opt/keycloak
# Copy the realm file into the appropriate directory
COPY tdei-realm.json /opt/keycloak/data/import/tdei-realm.json
COPY tdei /opt/keycloak/themes/tdei

RUN /opt/keycloak/bin/kc.sh build --db postgres --health-enabled=true

ENV KEYCLOAK_ADMIN=tdeiadmin
ENV KEYCLOAK_ADMIN_PASSWORD=Admin01*
# Start the Keycloak service
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev","--import-realm"]