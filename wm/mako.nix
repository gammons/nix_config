{
  programs.mako = {
    enable = true;
    maxVisible = 5;
    font = "Roboto Mono";
    backgroundColor = "#002b36AA";
    textColor="#fdf6e3";
    format = ''<b>%s</b> <span color="#93a1a1">(%a)</span>\n%b'';
    defaultTimeout = 10000;
  };
}
