{ pkgs, inputs, ... }: {
  vim.keymaps = [
    {
      key = "<leader>ff";
      desc = "File picker";
      mode = "n";
      silent = true;
      action = ":lua Snacks.picker.files()<cr>";
    }
    {
      key = "<leader>fg";
      desc = "Grep picker";
      mode = "n";
      silent = true;
      action = ":lua Snacks.picker.grep()<cr>";
    }
    {
      key = "<leader>fc";
      desc = "Command list";
      mode = "n";
      silent = true;
      action = ":lua Snacks.picker.commands()<cr>";
    }
    {
      key = "<leader>fac";
      desc = "AutoCommand list";
      mode = "n";
      silent = true;
      action = ":lua Snacks.picker.autocmds()<cr>";
    }
  ];

  vim.binds.whichKey.enable = true;
}
