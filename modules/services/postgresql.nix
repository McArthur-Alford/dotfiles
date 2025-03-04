{
  pkgs,
  self,
  config,
  ...
}:
{
  # sops.secrets = {
  #   pg_pass = {
  #     name = "peerix-public";
  #     format = "binary";
  #     sopsFile = "${self}/secrets/pg_pass.txt";
  #   };
  # };
  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "mydatabase" ];
  #   # enableTCPIP = true;
  #   # port = 5432;
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     #type database DBuser origin-address auth-method
  #     local all      all     trust
  #     # ... other auth rules ...

  #     # ipv4
  #     host  all      all     127.0.0.1/32   trust
  #     # ipv6
  #     host  all      all     ::1/128        trust
  #   '';
  #   initialScript = pkgs.writeText "backend-initScript" ''
  #     CREATE ROLE mcarthur WITH LOGIN PASSWORD 'mcarthur' CREATEDB;
  #     CREATE DATABASE mcarthur;
  #     GRANT ALL PRIVILEGES ON DATABASE mcarthur TO mcarthur;
  #   '';
  # };
  # services = {
  #   pgadmin = {
  #     enable = true;
  #     initialEmail = "initial@email.com";
  #     initialPasswordFile = config.sops.secrets.pg_pass.path;
  #     openFirewall = true;
  #     settings = {
  #       "ALLOWED_HOSTS" = [
  #         "192.168.0.0/16"
  #       ];
  #       "CONFIG_DATABASE_URI" = "postgresql://pgadmin:pgadmin@localhost/pgadmin";
  #     };
  #   };
  # };
  #   postgresql = {
  #     # authentication = ''
  #     #   local all pgadmin peer
  #     #   local all all trust
  #     # '';
  #     enable = true;
  #     ensureDatabases = [ "mydatabase" ];
  #     # authentication = pkgs.lib.mkOverride 10 ''
  #     #   #type database  DBuser  auth-method
  #     #   local all       all     trust
  #     # '';

  #     # initialScript = ''
  #     #   CREATE ROLE pgadmin WITH PASSWORD 'pgadmin' SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS LOGIN;
  #     #   CREATE DATABASE pgadmin;
  #     #   GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pgadmin;
  #     #   GRANT ALL PRIVILEGES ON DATABASE postgres TO pgadmin;
  #     #   GRANT ALL PRIVILEGES ON DATABASE pgadmin TO pgadmin;
  #     # '';
  #     # package = pkgs.postgresql_14;
  #   };
  # };
  # systemd.services.pgadmin.serviceConfig.SupplimentaryGroups = [ config.users.groups.keys.name ];
}
