{
  self,
  pkgs,
  lib,
  ...
}:
{
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };

    opts = {
      tabstop = 4;
      shiftwidth = 0;
      softtabstop = -1;
      expandtab = true;

      foldlevel = 3;
    };

    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        picker.enabled = true;
        indent.enabled = true;
        dim.enabled = true;
        scroll.enabled = true;
        statuscolumn.enabled = true;

        dashboard = {
          enabled = true;

          sections = [
            { section = "header"; }
            { section = "keys"; }
            { section = "projects"; }
            { section = "recent_files"; }
          ];
        };

        keymap = {
          enabled = true;
        };
      };
    };

    statusline.lualine.enable = true;
    autocomplete.nvim-cmp.enable = true;

    languages = {
      enableTreesitter = true;

      nix = {
        enable = true;
        format.type = [ "nixfmt" ];
      };

      rust.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
    };

    treesitter = {
      enable = true;
      fold = true;
    };

    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamed,unnamedplus";
    };

    visuals.nvim-web-devicons.enable = true;

    # This is necessary because nixfmt does not support different tabstops
    # And changing these values per language is gated behind https://github.com/NotAShelf/nvf/pull/1304
    luaConfigPost = "vim.api.nvim_create_autocmd(\"FileType\", {
        pattern = \"nix\",
        callback = function()
          vim.bo.tabstop = 2
        end,
      })";
  };
}
