local M = {}

local _has_updated_macro_rtp = false
local compiler_opts = {}
local _debug_traceback = debug.traceback

local function print_stdout(msg)
	local lines = vim.fn.split(msg, "\n")
	vim.fn.writefile(lines, "/dev/stdout")
end

local function clonetable(t)
	return { unpack(t) }
end

local function get_compiler_opts(filename)
	local opts = clonetable(compiler_opts)
	opts.filename = filename
  return opts
end

function M.setup(user_opts)
	compiler_opts = user_opts
end

--- Update `fennel.macro-path` with runtimepaths
--- We call this function during bootstrap and setup
local function update_fnl_macro_rtp()
  if _has_updated_macro_rtp then
    return
  end

	local fennel = require("fennel")
	local rtps = vim.api.nvim_list_runtime_paths()
	local templates = {
		-- lua base dir
		";%s/lua/?.fnl",
		";%s/lua/?/init.fnl",
		-- fnl base dir
		";%s/fnl/?.fnl",
		";%s/fnl/?/init.fnl",
	}
	for _, rtp in ipairs(rtps) do
		for _, template in ipairs(templates) do
			fennel["macro-path"] = fennel["macro-path"] .. string.format(template, rtp)
		end
	end

  _has_updated_macro_rtp = true
end

function M.eval(fnl, filename)
	local fennel = require("fennel")
  update_fnl_macro_rtp()
  debug.traceback = fennel.traceback

  local opts = get_compiler_opts(filename)

	local result = fennel.eval(fnl, opts)
	print_stdout(fennel.view(result))

  debug.traceback = _debug_traceback
end

function M.compile(input_file)
	local fennel = require("fennel")
  update_fnl_macro_rtp()
  debug.traceback = fennel.traceback

	local file_handle = assert(io.open(input_file))
	local fnl = file_handle:read("*a")

  local opts = get_compiler_opts(input_file)

	local lua = fennel.compileString(fnl, opts)
	print_stdout(lua)

  debug.traceback = _debug_traceback
end

return M
