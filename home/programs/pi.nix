{ inputs, config, ... }:

{
  imports = [ inputs.pi.homeModules.default ];

  programs.pi.coding-agent = {
    enable = true;
    environment.PI_CODING_AGENT_DIR.value = "${config.home.homeDirectory}/.pi/agent";
  };
}
