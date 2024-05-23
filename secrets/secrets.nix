let
  vael-callisto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDyOum7JvG+rfosYj8tavsLmE723pb/SGsle9qLZhb2c";
  root-callisto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAONM+pCdlHQ3kEL59m6fyQ2T//s9mUTyuwJH0k5v7Z1";
       callisto = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ58KCF3Y/zbedURlF+x9FKKcj58nRjGGHRa4Dt5IisF";
  users = [vael-callisto root-callisto];
  systems = [callisto];
in {
  "nordvpn.age".publicKeys = users ++ systems;
}
