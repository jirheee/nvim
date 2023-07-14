return {
  { "vimwiki/vimwiki" },

  {
    "vimwiki/vimwiki",
    event = "BufEnter *.md",
    keys = { "<leader>ww" },
    config = function()
      vim.api.nvim_set_keymap("n", "gtc", ":VimwikiToggleListItem<CR>", { desc = "Toggle list item" })
    end,
    init = function()
      vim.g.vimwiki_folding = ""
      vim.g.vimwiki_conceallevel = 0
      vim.g.vimwiki_list = {
        {
          path = "~/development/wiki",
          ext = ".md",
          syntax = "markdown",
        },
      }
      vim.g.vimwiki_ext2syntax = {
        [".md"] = "markdown",
        [".markdown"] = "markdown",
        [".mdown"] = "markdown",
      }
    end,
  },
}
