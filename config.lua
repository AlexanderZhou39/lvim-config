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
  {
    "nvim-lua/plenary.nvim"
  },
  {
    "nvim-pack/nvim-spectre"
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "ptdewey/yankbank-nvim",
    dependencies = "kkharji/sqlite.lua",
    config = function()
        require('yankbank').setup({
            persist_type = "sqlite",
        })
    end,
  },
}

require("telescope").load_extension("live_grep_args")

require("lvim.lsp.manager").setup("emmet_ls")

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
  v = { "<cmd>2ToggleTerm size=10 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=10 direction=horizontal<cr>", "Split horizontal" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "Find And Replace (Spectre)",
  t = { '<cmd>lua require("spectre").toggle()<CR>', "Toggle Spectre" },
}

lvim.builtin.which_key.mappings.s.t = {
  require('telescope').extensions.live_grep_args.live_grep_args, "Live grep args",
}

lvim.builtin.which_key.mappings.s.b = {
  "<cmd>lua require('telescope.builtin').buffers()<cr>", "buffers"
}

lvim.builtin.which_key.mappings.y = {
  "<cmd>YankBank<CR>", "yankbank"
}


local function clear_cmdarea()
  vim.defer_fn(function()
    vim.api.nvim_echo({}, false, {})
  end, 1500)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    if #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
      vim.cmd "silent w"

      local time = os.date "%I:%M %p"

      -- print nice colored msg
      vim.api.nvim_echo({ { "󰄳", "LazyProgressDone" }, { " file autosaved at " .. time } }, false, {})

      clear_cmdarea()
    end
  end,
})
