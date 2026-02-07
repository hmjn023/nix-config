_: {
  networking.extraHosts = ''
    127.0.0.1 cloud.opencloud.test
    127.0.0.1 traefik.opencloud.test
    127.0.0.1 keycloak.opencloud.test
  '';

  networking.nameservers = [
    "192.168.1.150"
  ];
}
