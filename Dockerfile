# Extend the Keycloak image
FROM quay.io/keycloak/keycloak:25.0.4

# Set the working directory
WORKDIR /opt/keycloak
# Copy the realm file into the appropriate directory
COPY tdei-realm.json /opt/keycloak/data/import/tdei-realm.json

#ENV used by build script to enable health endpoint 
ENV KC_HEALTH_ENABLED=true

RUN /opt/keycloak/bin/kc.sh build --db postgres

# Start the Keycloak service
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start","--import-realm","--optimized"]