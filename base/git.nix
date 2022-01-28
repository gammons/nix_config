{
  programs.git = {
    enable = true;
    userEmail = "grant@grant.dev";
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
