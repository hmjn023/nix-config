{pkgs, ...}: {
  home.packages = with pkgs; [];

  # Desktop Menu integration (Keep for configuration)
  xdg.configFile."menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
