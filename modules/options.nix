{ lib, nixpkgsLib }:
with lib;
with nixpkgsLib;
with builtins; {
  mkProvidesOption = args@{ providedText
    , initialProvidedText ? capitalize providedText, defaultPackage ? null
    , defaultPackageText ? "null", packageExample ? null, keyName ? "name"
    , keyType ? types.nullOr types.str, defaultKey ? null
    , defaultKeyText ? ''""'', keyExample ? null, keyText ? keyName
    , initialKeyText ? capitalize keyText, extraModules ? [ ] }:
    mkOption {
      description = ''
        ${initialProvidedText} to use.
      '';
      type = mkProvidesType args;
      default = { };
    };
  mkProvidesOptionSet = args@{ providedText
    , initialProvidedText ? capitalize providedText, defaultPackage ? null
    , defaultPackageText ? "null", packageExample ? null, keyName ? "name"
    , keyType ? types.nullOr types.str, defaultKey ? null
    , defaultKeyText ? ''""'', keyExample ? null, keyText ? keyName
    , initialKeyText ? capitalize keyText }: {
      package = mkOption {
        type = types.nullOr types.package;
        default = defaultPackage;
        defaultText = literalExpression defaultPackageText;
        ${guardNull packageExample "example"} =
          literalExpression packageExample;
        description = ''
          Package providing ${providedText}. This package will be installed to your profile.
          If <literal>null</literal> then ${providedText} is assumed to already be available in your profile.
        '';
      };
      ${keyName} = mkOption {
        type = keyType;
        default = defaultKey;
        defaultText = literalExpression defaultKeyText;
        ${guardNull keyExample "example"} = literalExpression keyExample;
        description =
          "${initialKeyText} of ${providedText} within the package.";
      };
    };
}
