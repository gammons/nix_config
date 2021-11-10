{
  programs.git = {
    enable = true;
    userEmail = "gammons@gmail.com";
    userName = "Grant Ammons";
    aliases = {
      fuckit = "!git clean -d -f && git reset --hard";
    };

    extraConfig = {
      push = {
        default = "upstream";
      };
      pull = {
        rebase = true;
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
