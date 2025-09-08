
# Keycloak 
Keycloak serves as the central authentication and token management server for the TDEI project. It provides secure and efficient identity management, handling all aspects of user registration, authentication, and token management.

## Create an Environment File (.env)

Create a file named .env in your project directory and add the required environment variables:

| Environment Variable           | Value                                  | Description |
|--------------------------------|----------------------------------------|-------------|
| `KC_DB`                        | `postgres`                             | Database type used by Keycloak |
| `KC_DB_URL`                    | `jdbc:postgresql://your-db-host:5432/your-db-name` | Database connection URL |
| `KC_DB_USERNAME`               | `your-db-username`                     | Database username |
| `KC_DB_PASSWORD`               | `your-db-password`                     | Database password |
| `KC_DB_SCHEMA`                 | `keycloak`                             | Database schema for Keycloak |
| `KC_HEALTH_ENABLED`            | `true`                                 | Enables health check endpoints |
| `KC_HOSTNAME_STRICT`           | `false`                                | Disables strict hostname checks |
| `KC_HTTP_ENABLED`              | `true`                                 | Enables HTTP support |
| `KC_PROXY`                     | `edge`                                 | Proxy mode for Keycloak |
| `KC_PROXY_ADDRESS_FORWARDING`  | `true`                                 | Enables proxy address forwarding |
| `KEYCLOAK_ADMIN`               | `admin`                                | Keycloak admin username |
| `KEYCLOAK_ADMIN_PASSWORD`      | `admin-password`                       | Keycloak admin password |

## Docker Build Command to Accept the .env File

Use the --env-file option when running the container:

Build the Docker Image

```
docker build -t keycloak-custom .
```
Run the Docker Container with the .env File

```
docker run --env-file .env -p 8080:8080 keycloak-custom
```

### Alternative: Pass Environment Variables Manually

Instead of using a .env file, you can pass variables directly in the command:

docker run -e KC_DB_URL="jdbc:postgresql://your-db-host:5432/your-db-name" \
           -e KC_DB_USERNAME="your-db-username" \
           -e KC_DB_PASSWORD="your-db-password" \
           -e KEYCLOAK_ADMIN="admin" \
           -e KEYCLOAK_ADMIN_PASSWORD="admin-password" \
           -p 8080:8080 keycloak-custom

## Keycloak Portal Access

Once the container is running, access the Keycloak Admin Console at:
- URL: http://localhost:8080/admin
- Default Admin Credentials:
    - Username: admin
    - Password: admin (Update credentials for security!)

## For new clients or installation ensure 
- user admin@tdei.com creds is reset for security and it is created with default password in config.
- credential secrets are regenerted for each TDEI clients
- Realm email SMTP password is set. 

## Custom Themes
The TDEI custom theme is copied to Keycloak’s themes directory

## Realm Import
The TDEI realm configuration is imported on startup from `tdei-realm.json`