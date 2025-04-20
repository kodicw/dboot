{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.python;
in
{
  options.${namespace}.tools.python = {
    enable = mkEnableOption "Whether or not to enable python.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ruff
      (python312.withPackages (ps: with ps; [
        html5lib
        playwright
        # pyinstaller
        pandas
        pexpect
        pillow
        pyinfra
        netifaces
        pyserial
        cryptography
        tqdm
        schedule
        rns
        requests
        nomadnet
        typer
        flask
        selenium
        sqlalchemy
        numpy
        ffmpeg-python
        openpyxl
        google-api-python-client
        pyquery
        joblib
        fabric
        feedparser
        langchain
        beautifulsoup4
        rich
        openai
        python-lsp-server
      ]))
    ];
  };
}
