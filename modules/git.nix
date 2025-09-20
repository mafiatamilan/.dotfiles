{ ... }:

{
  programs.git = {
    enable = true;
    userName = "mafiatamilan";
    userEmail = "mafiatamilan@yahoo.com";

    extraConfig = {
      core.editor = "vim";
      push.default = "simple";
      credential.helper = "store";
      url."https://github.com/".insteadOf = "git@github.com:";
    };
  };
}

