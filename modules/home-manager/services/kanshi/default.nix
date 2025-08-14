_: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        output = {
          criteria = "BOE 0x095F Unknown";
          mode = "2256x1504@59.99900";
          position = "0,0";
          scale = 1.333333;
        };
      }
      {
        output = {
          criteria = "Dell Inc. DELL G2724D 82K16Y3";
          mode = "2560x1440@165.080002";
          position = "0,0";
          scale = 1.0;
        };
      }
      {
        profile = {
          name = "desktop";
          outputs = [ { criteria = "Dell Inc. DELL G2724D 82K16Y3"; } ];
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
              # mode = "2560x1440@59.95100";
              # position = "2560,0";
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
