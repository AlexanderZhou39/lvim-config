-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.plugins = {
  { "neanias/everforest-nvim" },
  { "frenzyexists/aquarium-vim" },
  { "titanzero/zephyrium" },
  { "ribru17/bamboo.nvim" },
  { "brenton-leighton/multiple-cursors.nvim",
    config = true,
    keys = {
      {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i"}},
      {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i"}},
      {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}},
    },
  },
  {
    "AckslD/swenv.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
          "nvim-telescope/telescope-live-grep-args.nvim" ,
          -- This will not install any breaking changes.
          -- For major updates, this must be adjusted manually.
          version = "^1.0.0",
      },
    },
  },
}

require("telescope").load_extension("live_grep_args")

lvim.colorscheme = "bamboo"

local function open_nvim_tree()
require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

lvim.builtin.which_key.mappings.s.t = {
  require('telescope').extensions.live_grep_args.live_grep_args, "Live grep args",
}

