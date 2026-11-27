{ ... }:

{
  services.davfs2 = {
    enable = true;
    settings = {
      globalSection = {
        cache_size = 512;
      };
    };
  };

  fileSystems."/home/raia/Nextcloud" = {
    device = "https://cloud.home.arpa/remote.php/dav/files/raia/";
    fsType = "davfs";

    options = [
      "rw"
      "_netdev"
      "noauto"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "x-systemd.mount-timeout=30s"
      "uid=raia"
      "gid=users"
      "file_mode=0600"
      "dir_mode=0700"
    ];
  };
}
