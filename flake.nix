{
  outputs = { self }:
    let
      preCall = with builtins;
        f:
        let
          g = a:
            if isAttrs a then
              let x = f a;
              in {
                __functor = self: b: g b;
              } // x // {
                ${if x ? __functor then null else "__functionArgs"} =
                  functionArgs f;
              }
            else
              f a;
        in g { };
    in { lib = preCall (import ./default.nix); };
}
