{
  description = "Harden up some basic systemd services";

  outputs = { self, nixpkgs }: {
    nixosModules.simple-service = { lib, pkgs, config, ... }: {
      options = with lib; {
        systemd.harden = mkOption {
          default = { };
          type = types.loaOf (types.submodule ({ name, ... }: {
            options = {
              name = mkOption {
                type = types.str;
                default = name;
              };
              db = mkOption {
                type = types.str;
                default = "host=/run/postgresql dbname=${name} sslmode=disable";
              };
              command = mkOption {
                type = types.str;
                default = "";
              };
              hasState = mkOption {
                type = types.bool;
                default = true;
              };
            };
          }));
        };
      };

      config = with lib; {
        users.users = mapAttrs
          (name: attrs: {
            isSystemUser = true;
            group = name;
          })
          (config.systemd.harden);

        users.groups = mapAttrs (name: attrs: { }) (config.systemd.harden);

        systemd.services = mapAttrs
          (name: attrs: {
            enable = true;
            after = [ "network-online.target" "postgresql.service" ];
            wantedBy = [ "multi-user.target" ];

            confinement = {
              enable = true;
              binSh = null;
              packages = with pkgs; [
                cacert
              ];
            };

            environment = {
              SSL_CERT_DIR = "${pkgs.cacert}/etc/ssl/certs";
              CURL_CA_BUNDLE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
            };

            serviceConfig = {
              Restart = "always";
              RestartSec = "10";

              User = name;
              TemporaryFileSystem = mkForce [ "/" "/bin:ro" "/etc" ];
              BindReadOnlyPaths = [
                "-/etc/nixos/bin/${name}:/bin"
                "/etc/hosts"
                "/etc/resolv.conf"
              ];
              ExecStart = mkDefault "/bin/${name} ${attrs.command}";
              WorkingDirectory = "/var/lib/${name}";
              StateDirectory = "${name}";
              BindPaths = [
                "/var/lib/${name}"
                "-/run/postgresql"
                "-/run/mysqld"
                "-/var/run/postgresql"
                "-/var/run/mysqld"
              ];
              PrivateUsers = true;
              DynamicUser = mkForce false;
              PrivateDevices = true;
              ProtectClock = true;
              ProtectKernelLogs = true;
              SystemCallArchitectures = "native";
              RestrictNamespaces = true;
              MemoryDenyWriteExecute = true;
              CapabilityBoundingSet = [ "" ];
              AmbientCapabilities = [ "" ];
              #IPAddressDeny = "any";
              #IPAddressAllow = "localhost";
              RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6";
              RestrictSUIDSGID = true;
              NoNewPrivileges = true;
              RemoveIPC = true;
              LockPersonality = true;
              ProtectHome = true;
              ProtectHostname = true;
              RestrictRealtime = true;
              SystemCallFilter = [ "@system-service" "~@privileged" "~@resources" ];
              SystemCallErrorNumber = "EPERM";
            };
          })
          (config.systemd.harden);
      };
    };
  };
}
