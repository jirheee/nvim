-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_augroup("vimwikiauto", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  group = "vimwikiauto",
  callback = function()
    local in_wiki_directory = false
    for _, x in pairs(vim.g.vimwiki_list) do
      local path = x.path
      if vim.fn.expand("%:p:h") == vim.fn.expand(path) then
        in_wiki_directory = true
      end
    end

    if not in_wiki_directory then
      return
    end

    if vim.fn.line("$") > 1 then
      return
    end

    local template = {
      "---",
      "layout  : wiki",
      "title   : ",
      "date    : " .. vim.fn.strftime("%Y-%m-%d %H:%M:%S +0900"),
      "summary : ",
      "updated : " .. vim.fn.strftime("%Y-%m-%d %H:%M:%S +0900"),
      "tag     : ",
      "toc     : true",
      "public  : true",
      "parent  : ",
      "latex   : false",
      "resource: " .. vim.fn.substitute(vim.fn.system("uuidgen"), "\n", "", ""),
      "---",
      "* TOC",
      "{:toc}",
      "",
      "# ",
    }

    for index, value in ipairs(template) do
      vim.fn.setline(index, value)
    end

    vim.fn.execute("normal! G")
    vim.fn.execute("normal! $")

    print("new wiki page has been created")
  end,
})
-- TODO:
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.md",
--   group = "vimwikiauto",
--   callback = function()
--     print("bufwritepree")
--
--     vim.mo:q
--
--     print("ha" .. vim.g.modified)
--   end,
-- })
