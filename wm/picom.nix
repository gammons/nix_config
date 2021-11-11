{
  services.picom = {
    enable = true;
    vSync = true;
    backend = "xr_glx_hybrid";
    extraOptions = ''
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
      unredir-if-possible = true;
      xrender-sync-fence = true;
    '';
  };
}
