return {
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true,
  keys = {
    { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
    { "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", desc = "Go to next harpoon mark" },
    { "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
  },
}
