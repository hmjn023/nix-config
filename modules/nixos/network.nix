{ config, pkgs, ... }:

{
	networking.extraHosts = 
		''
		127.0.0.1 cloud.opencloud.test127
		127.0.0.1 traefik.opencloud.test
		127.0.0.1 keycloak.opencloud.test
		''
		;
}
