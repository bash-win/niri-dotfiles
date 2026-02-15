return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- completion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",

      -- snippets
      "L3MON4D3/LuaSnip",
    },

    config = function()
      -- --------------------------------
      -- Mason
      -- --------------------------------
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "rust_analyzer",
          "ts_ls",
          "zls",
          "lua_ls",
        },
      })

      -- --------------------------------
      -- Capabilities
      -- --------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- --------------------------------
      -- Keymaps
      -- --------------------------------
      local function on_attach(_, bufnr)
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      -- --------------------------------
      -- LSP CONFIG (NEW API)
      -- --------------------------------

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
	    check = {
		command = "clippy",
	    },
	    rustfmt = {
		enable = true,
	    },
          },
        },
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
      })

      vim.lsp.config("zls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("tinymist", {
	  capabilities = capabilities,
	  on_attach = on_attach,
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- --------------------------------
      -- Enable servers
      -- --------------------------------
      vim.lsp.enable({
        "clangd",
        "rust_analyzer",
        "ts_ls",
        "zls",
        "lua_ls",
	"tinymist",
      })

      -- --------------------------------
      -- nvim-cmp
      -- --------------------------------
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },
}

