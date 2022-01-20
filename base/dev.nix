{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    direnv
    stdenv
    kubectl
    k9s
    kubernetes-helm
    docker
    docker-compose
    openssl
    zlib
    solargraph
  ];
}
