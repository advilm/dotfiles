_: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        output = {
          criteria = "BOE 0x095F Unknown";
          mode = "2256x1504@59.99900";
          scale = 1.333333;
        };
      }
      {
        output = {
          criteria = "Dell Inc. DELL G2724D 82K16Y3";
          mode = "2560x1440@143.967";
          scale = 1.0;
        };
      }
      {
        output = {
          criteria = "Dell Inc. DELL E2416H G0RH169H06LU";
          mode = "1920x1080@60.000";
          scale = 1.0;
          transform = "270";
        };
      }
      {
        output = {
          criteria = "Samsung Electric Company SAMSUNG 0x01000E00";
          mode = "3840x2160@30.000000";
          scale = 2.0;
        };
      }
      {
        profile = {
          name = "desktop";
          outputs = [
            {
              criteria = "Dell Inc. DELL G2724D 82K16Y3";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "laptop";
          outputs = [
            {
              criteria = "BOE 0x095F Unknown";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "laptop-home";
          outputs = [
            {
              criteria = "BOE 0x095F Unknown";
              status = "disable";
            }
            {
              criteria = "Dell Inc. DELL G2724D 82K16Y3";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "laptop-home-vertical";
          outputs = [
            {
              criteria = "BOE 0x095F Unknown";
              status = "disable";
            }
            {
              criteria = "Dell Inc. DELL G2724D 82K16Y3";
              status = "enable";
            }
            {
              criteria = "Dell Inc. DELL E2416H G0RH169H06LU";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "laptop-tv";
          outputs = [
            {
              criteria = "BOE 0x095F Unknown";
              status = "disable";
            }
            {
              criteria = "Samsung Electric Company SAMSUNG 0x01000E00";
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "laptop-external";
          outputs = [
            {
              criteria = "BOE 0x095F Unknown";
              status = "disable";
            }
            {
              criteria = "*";
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
