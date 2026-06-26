{lib, user, moduleSettings, ...}: let
  useDvorak = lib.attrByPath ["keyd" "useDvorak"] true moduleSettings;
in {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*" "-8968:4e4f"];
      settings.main.capslock = "overload(meta, esc)";
      settings.global.default_layout =
        if useDvorak
        then "dvorak"
        else "us";
      extraConfig = lib.optionalString useDvorak ''
        [dvorak:layout]
        ' = -
        , = w
        - = [
        . = v
        / = z
        1 = 1
        2 = 2
        3 = 3
        4 = 4
        5 = 5
        6 = 6
        7 = 7
        8 = 8
        9 = 9
        ; = s
        = = ]
        [ = /
        \ = \
        ] = =
        a = a
        b = x
        c = j
        d = e
        e = .
        f = u
        g = i
        h = d
        i = c
        j = h
        k = t
        l = n
        m = m
        n = b
        o = r
        p = l
        q = '
        r = p
        s = o
        t = y
        u = g
        v = k
        w = ,
        x = q
        y = f
        z = ;
        shift = layer(dvorak_shift)

        [dvorak_shift:S]
        ' = _
        , = W
        - = {
        . = V
        / = Z
        1 = !
        2 = @
        3 = #
        4 = $
        5 = %
        6 = ^
        7 = &
        8 = *
        9 = (
        ; = S
        = = }
        [ = ?
        \ = |
        ] = +
        a = A
        b = X
        c = J
        d = E
        e = >
        f = U
        g = I
        h = D
        i = C
        j = H
        k = T
        l = N
        m = M
        n = B
        o = R
        p = L
        q = "
        r = P
        s = O
        t = Y
        u = G
        v = K
        w = <
        x = Q
        y = F
        z = :
      '';
    };
  };

  users.users.${user}.extraGroups = ["keyd"];

  # Make libinput treat keyd as internal keyboard
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd*keyboard
    AttrKeyboardIntegration=internal
  '';
}
