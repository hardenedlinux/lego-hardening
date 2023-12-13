{self}:
{
  isolate = {
    CapabilityBoundingSet = "";
    DeviceAllow = "";
    IPAddressDeny = "any";
    KeyringMode = "private";
    LockPersonality = true;
    MemoryDenyWriteExecute = true;
    NoNewPrivileges = true;
    NotifyAccess = "none";
    ProcSubset = "pid";
    RemoveIPC = true;

    PrivateDevices = true;
    PrivateMounts = true;
    PrivateNetwork = true;
    PrivateTmp = true;
    PrivateUsers = true;

    ProtectClock = true;
    ProtectControlGroups = true;
    ProtectHome = true;
    ProtectKernelLogs = true;
    ProtectKernelModules = true;
    ProtectKernelTunables = true;
    ProtectHostname = true;
    ProtectProc = "invisible";
    ProtectSystem = "strict";
    RestrictAddressFamilies = "";
    RestrictNamespaces = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
  };
  cap = {
    AmbientCapabilities = [
      "CAP_NET_BIND_SERVICE"
      "CAP_NET_RAW"
    ];
    CapabilityBoundingSet = ["CAP_NET_BIND_SERVICE"];
  };

  networked = self.isolate // {
    IPAddressDeny = [""];
    PrivateNetwork = false;
    RestrictAddressFamilies = [
      "AF_INET"
      "AF_INET6"
    ];
  };

  socketed = self.isolate // {
    RestrictAddressFamilies = ["AF_UNIX"];
  };
}
