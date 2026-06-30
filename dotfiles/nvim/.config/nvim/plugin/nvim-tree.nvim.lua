vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-tree.lua", version = "nvim-tree-v1.17.0", name = "nvim-tree" },
})

require("nvim-tree").setup()

local nvimtree_open = function()
    require('nvim-tree.api').tree.open()
end

vim.api.nvim_create_user_command("Ex", nvimtree_open, {})
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

