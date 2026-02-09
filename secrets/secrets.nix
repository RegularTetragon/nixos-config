let
  vael-callisto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyOum7JvG+rfosYj8tavsLmE723pb/SGsle9qLZhb2c";
  root-callisto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAONM+pCdlHQ3kEL59m6fyQ2T//s9mUTyuwJH0k5v7Z1";
  vael-ganymede = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEysX9bOso64urm2QWLkqiq8Ik2iClzJuTbabx4okaX";
  root-ganymede = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH5ateMldlulJjMWE+39pWhqRbdRM49duBKV2Pu2jaHn";
  callisto =      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ58KCF3Y/zbedURlF+x9FKKcj58nRjGGHRa4Dt5IisF";
  ganymede =      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILEGejvZQECWRMX2nQTS6m4AN/7GLKykyFNV/UTgrXMO";
  users = [
    vael-callisto
    root-callisto
    vael-ganymede
    root-ganymede
  ];
  systems = [ callisto ganymede ];
in
{
  "nordvpn.age".publicKeys = users ++ systems;
}
