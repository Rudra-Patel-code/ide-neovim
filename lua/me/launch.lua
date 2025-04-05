-- LAZY_PLUGIN_SPEC is the table that collects all plugin specs for lazy.nvim
LAZY_PLUGIN_SPEC = {}

-- Helper function to import plugin specs dynamically
-- Usage: spec("user.plugins.git") will insert { import = "user.plugins.git" } into LAZY_PLUGIN_SPEC
function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end
