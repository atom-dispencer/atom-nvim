-- This file is run by Neovim whenever a .java file is opened
print("Java.lua > Configuring nvim-jdtls")
local jdtls = require("jdtls")

-- Original configuration inspired by:
-- https://medium.com/@chrisatmachine/lunarvim-as-a-java-ide-da65c4a77fb4
-- https://github.com/mfussenegger/nvim-jdtls


-- JDT.LS temporary files / workspace
-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local workspace_directory = vim.fn.stdpath("data") .. "/atom/java-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local unique_workspace_dir = workspace_directory .. project_name

-- Optional JDT.lS configuration:
-- JDT.LS install location
local jdtls_install_location = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
-- JDT.LS version (from the name of the launcher: nvim-data\mason\packages\jdtls\plugins\org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar)
-- Configure for windows. Can detect Mac/Linux at this point too but no need yet.
-- local jdtls_version = "1.6.700.v20231214-2017"
-- local os_config = "win"


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
print("Java.lua > Configuring...")
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = { vim.fn.stdpath("data") .. "\\mason\\bin\\jdtls.cmd" },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },

  
  -- Initialise Codelense and set up debug adapter
  on_attach = function(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)

    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    vim.lsp.on_attach(client, bufnr) -- Adapted from: require('lvim.lsp').on_attach(...)
    local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
    if status_ok then
      jdtls_dap.setup_dap_main_class_configs()
    end
  end
}


print("Java.lua > Creating autocmd...")
-- Configure Codelens for Java
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})


-- Formatting would be set up here if I were using LunarVim, but I'm not!
-- Hence, formatting is done by conform.nvim and configured when lazy.nvim loads it


-- FINAL STEP: Pass the completed config off to JDT.LS
-- This starts a new client & server, or attaches to an existing client & server depending on the `root_dir`.
print("Java.lua > Attaching...")
require('jdtls').start_or_attach(config)
