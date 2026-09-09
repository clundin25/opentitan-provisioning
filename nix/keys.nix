# SSH public keys for Provisioning Appliance administration
# Please keep alphabetized within a group.
let
  clundin = [
    # clundin
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8bsALwjQW9PZde+p6Fjwdz4UUB72O+OS339/wC56yD"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpNIWX9+v9baRpgPC4DQIzIXpMntGCJyyL4btjdfE12RmaqrnRxJeidyR1CLcnLoclG2xJW2HgXDLYw8fE6oCwyZ89ZR0/EqgpNH+6h4FjWI/vTGT1HYdzvBV8QGkiS7ZlTk5r3H1nlMlMyhj2bvdqzztgJ2U87bJYIA1mpQ0/c/nnpr/RgW6zsWaGqk6NCkxiEEdspzJvMxqmBHrHTXxUzUltScCHhJZlBByDWndqLAzlYtJ5bqOxuzalTacekR/3TKZ6ZEPbvQA1jbo6C4M3bN+mlQ7KuJi8jErA4f6V34UmftXaP2yHP2HcmVue79yD2cbyO1Cd0SUZz/g0jnL8oxIFFg0er4h0Zoff3RckI7XfxSWqfOb2rAWdYYAl2Z/c8v3Qm20DwtW3dZ0yJu12ypn3MEJ2NanfahsT85OLBRlljpPSRlZYBVCF0EawJY2IOnOMGB7Hq/JqvNXnsUVgELpZiS5CcjY5zBwDCbK7vQVilPjBf2jWalRqXJvDfRE= clundin@clundin-glinux.c.googlers.com"
  ];
in
{
  inherit clundin;
  admin_keys = clundin;

  googler_keys = [
    # amitkh
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEao/69xPyAhZNHUIhiqvDT/q+XQ4mEvLoOwiVDN2W0T"
    # clundin
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8bsALwjQW9PZde+p6Fjwdz4UUB72O+OS339/wC56yD"
    # cfrantz
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGaE+OpSSfjOO/J6ap0dpNWHwqG0IsuMK4Ca0LY2n3L cfrantz@cfrantz-desktop.svl.corp.google.com"
    # jhand
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNAmcxogmvhKGQy/kd5R+uB382XiSb1p/hlqx/lJv3IcxT3JDVk2cRuVxipirplizT6g5+a5FWH6fGrOizQ/Rd0= publickey"
    # josecipriano
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqxIT54u8MjPlfrEbBNI01f1irf27GfeZF9uCjPdkaI josecipriano@josecipriano.c.googlers.com"
    # moidx
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAING7nHmIo6v/jHTFuLGlALBM9bJ+p8WI4H6NZCREkxxc miguelosorio@google.com"
    # sileno
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdco7xfZ3kPkSYrVWZsGWYB8VuRPTT8FupUXegAj2+n sileno@sileno-caliptra.c.googlers.com"
    # ttrippel
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAC3/lGx3rPr9Nns3aAS8faxKHOj/jgqLNFpjfXehz2kGhNC2EGRibXBHHP738KEG+rjA8HOsG8oHFmTFcOBJf+UqgDNmIfx7M5Db3cEgvhMcZSWck3Nb6ouIBwVchFgAupohpKmGroNuLB5QDuOE3cA8U7zN3y1L8uhUrDAxNPmS2Dvag== ttrippel@ttrippel.svl.corp.google.com"
    # zhalvorsen
    "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBLCee6PZ63j9MXxo2LIB6K7I5WmIKJAWdww922p9klsKVhLkMpNPXkLtYaf44GDLSmNO1j2stkXw174agt722rAa6fNInSCY8HPpAlyAJ7xELEGDOb5FfQVJU5ruGYJ7LQ== zhalvorsen@zhalvorsen.c.googlers.com"
    # anamendes23
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBO22BHitOGrsd2rHMBl2M4L9AtbE6gtiiVxQpPcS9tJKB74HW3O9Wnfs3sLW2wrxIQ7VD4OWDBiqpcJpiLGIsOg= publickey"
  ];
}
