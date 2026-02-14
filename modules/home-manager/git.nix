{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
      user = {
        email = "hmjn023@gmail.com";
        name = "hmjn";
      };
      credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      light = false;
      side-by-side = true;
      # Enable mouse scrolling in less
      pager = "less -R --mouse";
    };
  };
}
