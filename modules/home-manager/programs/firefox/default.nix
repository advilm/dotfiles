{user, ...}: {
  programs.firefox = {
    enable = true;
    # https://github.com/llakala/nixos/blob/0d43dd0b8950d5a2f21bbc27bd3d068ea2c70615/apps/gui/firefox/policies.nix
    policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;

      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "never";

      OverrideFirstRunPage = "";
      PictureInPicture.Enabled = false;
      PromptForDownloadLocation = false;

      HardwareAcceleration = true;
      TranslateEnabled = true;

      Homepage.StartPage = "previous-session";

      UserMessaging = {
        UrlbarInterventions = false;
        SkipOnboarding = true;
      };

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      DNSOverHTTPS.Enabled = true;

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      # Handlers.schemes.vscode =
      # {
      #   action = "useSystemDefault";
      #   ask = false;
      # };
    };
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "signon.rememberSignons" = false;
        "browser.warnOnQuit" = false;
        "browser.aboutConfig.showWarning" = false;
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "";
        "browser.ml.chat.enabled" = false;
        "general.autoScroll" = true;

        "browser.download.dir" = "/home/${user}/downloads";
        "browser.download.folderList" = 2;

        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.quickactions" = false;
      };
    };
  };
}
