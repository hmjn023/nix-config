_: {
  networking.extraHosts = ''
    127.0.0.1 cloud.opencloud.test
    127.0.0.1 traefik.opencloud.test
    127.0.0.1 keycloak.opencloud.test
  '';

  networking.nameservers = [
    "192.168.1.150"
    "1.1.1.1" # Cloudflare DNS
    "8.8.8.8" # Google DNS
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 8000 8188 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
}
