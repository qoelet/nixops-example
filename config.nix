let
  nixopsExample = { config, pkgs, ... }:

  let
    myApp = pkgs.haskellPackages.callPackage (import ./.) {};
  in
  {
    systemd.services.myApp = {
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "simple";
        User = "root";
        ExecStart = ''${myApp}/bin/${myApp.pname}'';
      };
    };
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 8080 ];
  };

  testInstance = nixopsExample;
in
  {
    network.description = "Example";
    testInstance = nixopsExample;
  }
