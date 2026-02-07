{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "192.168.1.26" = {
        hostname = "192.168.1.26";
        user = "hmjn";
      };
      "github github.com" = {
        hostname = "ssh.github.com";
        identityFile = "~/.ssh/github";
        user = "git";
        port = 443;
      };
      "local" = {
        hostname = "localhost";
        user = "hmjn";
        port = 18442;
        proxyCommand = "quicssh-rs client quic://%h:%p";
      };
      "fukuoka" = {
        hostname = "fukuoka.j.kisarazu.ac.jp";
        user = "sdj23b11";
      };
      "server" = {
        hostname = "192.168.1.100";
        user = "hmjn";
        port = 22;
      };
    };
  };
}
