let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  omnibus = import (
    (fetchTarball {
      url = "https://github.com/tao3k/omnibusSrc/archive/${lock.nodes.omnibusSrc.locked.rev}.tar.gz";
      sha256 = lock.nodes.omnibusSrc.locked.narHash;
    })
  );
in
omnibus.call-flake ./.
