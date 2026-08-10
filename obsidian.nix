{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  vim.notes.obsidian = {
    enable = true;
    setupOpts = {
      legacy_commands = false;
      sync.enable = true;
      workspaces = [
        {
          name = "second_brain";
          path = "~/Desktop/notes";
        }
      ];

      note_id_func = lib.generators.mkLuaInline ''
        require("obsidian.builtin").title_id
      '';
    };
  };

  vim.languages.markdown = {
    enable = true;
    extensions.render-markdown-nvim.enable = true;
  };
}
