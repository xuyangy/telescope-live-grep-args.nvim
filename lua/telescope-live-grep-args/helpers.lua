local M = {}

local quote_default_opts = {
  quote_char = '"',
}

local special_chars = {
  ["\\"] = true,
  ["."] = true,
  ["*"] = true,
  ["+"] = true,
  ["-"] = true,
  ["?"] = true,
  ["|"] = true,
  ["("] = true,
  [")"] = true,
  ["["] = true,
  ["]"] = true,
  ["{"] = true,
  ["}"] = true,
  ["^"] = true,
  ["$"] = true,
}

M.quote = function(value, opts)
  opts = opts or {}
  opts = vim.tbl_extend("force", quote_default_opts, opts)

  local quoted = value:gsub(opts.quote_char, "\\" .. opts.quote_char)
  return opts.quote_char .. quoted .. opts.quote_char
end

M.escape = function(value, opts)
  opts = opts or {}
  opts = vim.tbl_extend("force", quote_default_opts, opts)

  -- Escape special characters
  local escaped = value:gsub(".", function(char)
    if special_chars[char] then
      return "\\" .. char
    else
      return char
    end
  end)

  local quoted = escaped:gsub(opts.quote_char, "\\" .. opts.quote_char)
  return opts.quote_char .. quoted .. opts.quote_char
end

return M
