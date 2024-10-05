--
-- Language configuration
--
local module = {}

module.Languages = {

	vim = {
		enabled = true,
		treesitter = { "vim", "vimdoc" },
	},
	markdown = {
		enabled = true,
		treesitter = { "yaml", "json", "xml" },
	},
	matlab = {
		enabled = true,
		mason_install = { "matlab-language-server" },
		mason_lspconfig = {
			matlab_ls = {
				settings = {
					MATLAB = {
						indexWorkspace = true,
						installPath = "",
						matlabConnectionTiming = "onStart",
						telemetry = false,
					},
				},
			},
		},
	},
	lua = {
		enabled = true,
		conform = { "stylua" },
		treesitter = { "lua" },
		mason_install = { "lua-language-server", "stylua", "luacheck" },
		mason_lspconfig = {
			lua_ls = {
				-- Configure for Neodev
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		},
	},
	python = {
		enabled = true,
		conform = { "isort", "black" },
		treesitter = { "python" },
		mason_install = { "python-lsp-server", "black" }, -- Should be a list?
		mason_lspconfig = {
			pylsp = {},
		},
	},
	java = {
		enabled = false,
		treesitter = { "java" },
	},
	elixir = {
		enabled = false,
		conform = { "mix" },
		treesitter = { "elixir", "eex" },
	},
	haskell = {
		enabled = true,
		mason_install = { "haskell-language-server", "ormolu", "hlint", "haskell-debug-adapter" },
		mason_lspconfig = {
			hls = {},
		},
	},
}


--
-- Functions and stuff :)
--

local function CollectKeyed(key)
	local result = {}
	for lang, lang_config in pairs(module.Languages) do
		--
		-- Check whether there is a treesitter config for the language
		local keyed = lang_config[key]

    -- Sanity checks
    if not lang_config.enabled then
      goto continue
    end
    if keyed == nil then
      goto continue
    end

    -- Processing
    local entries = {}
    --
    -- Append the config to the entries map
    for _, name in pairs(keyed) do
      table.insert(entries, name)
    end

    result[lang] = entries

    ::continue::
	end

	return result
end

 function CollectLspConfig()
  local result = {}

  for lang,config in pairs(module.Languages) do
    if config.enabled and config["mason_lspconfig"] ~= nil then
      for lspname,lspconfig in pairs(config["mason_lspconfig"]) do
        result[lspname] = lspconfig
      end
    end
  end

  return result
end

local function Flatten(input)
	local result = {}
	for _, arr in pairs(input) do
		for _, data in ipairs(arr) do
			table.insert(result, data)
		end
	end
	return result
end


module.MasonEnsureInstalled = Flatten(CollectKeyed("mason_install"))
module.MasonLspConfig = CollectLspConfig()
module.ConformByFt = CollectKeyed("conform")
module.TreesitterInstall = Flatten(CollectKeyed("treesitter"))

return module
