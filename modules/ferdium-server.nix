{ config, pkgs, ... }:
{

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      ferdium-server = {
        # ...
        image = "ferdium/ferdium-server:latest";
        name = "ferdium-server";
        environment = {
          NODE_ENV = "production";
          APP_URL = "https://localhost";
          DB_CONNECTION = "sqlite";
          DB_HOST = "127.0.0.1";
          DB_PORT = "3306";
          DB_USER = "root";
          DB_PASSWORD = "password";
          DB_DATABASE = "ferdium";
          DB_SSL = false;
          MAIL_CONNECTION = "smtp";
          SMTP_HOST = "127.0.0.1";
          SMTP_PORT = "2525";
          MAIL_SSL = false;
          MAIL_USERNAME = "username";
          MAIL_PASSWORD = "password";
          MAIL_SENDER = "noreply@ferdium.org";
          IS_CREATION_ENABLED = true;
          IS_DASHBOARD_ENABLED = true;
          IS_REGISTRATION_ENABLED = true;
          CONNECT_WITH_FRANZ = false;
          DATA_DIR = "/data";
          JWT_USE_PEM = true;
        };
        volumes = [
          "ferdium-database-vol:/data"
          "ferdium-recipes-vol:/app/build/recipes"
        ];
        ports = "3333:3333";
  
          
        
      };
    };
  };
  
}
  
