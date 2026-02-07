_: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "hmjn023@gmail.com";
        name = "hmjn";
      };
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
