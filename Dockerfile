# Extend the Keycloak image
FROM quay.io/keycloak/keycloak:25.0.4

# Set the working directory
WORKDIR /opt/keycloak
# Copy the realm file into the appropriate directory
COPY tdei-realm.json /opt/keycloak/data/import/tdei-realm.json
COPY Microsoft_RSA_Root_Certificate_Authority_2017.crt /opt/keycloak/.postgresql/root.crt

COPY ./themes/tdei-theme/ /opt/keycloak/themes/tdei-theme

RUN /opt/keycloak/bin/kc.sh build --db postgres

# Start the Keycloak service
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start","--import-realm","--optimized"]