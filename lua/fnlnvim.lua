local M = {}

local _has_updated_macro_rtp = false
local compiler_opts = {}
local _debug_traceback = debug.traceback

--- print to stdout
--- TODO: figure out a way to get this to work on Windows
---@param msg string
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

local function setup_compiler()
	local fennel = require("fennel")
	update_fnl_macro_rtp()
	debug.traceback = fennel.traceback
	return fennel
end

local function teardown()
	debug.traceback = _debug_traceback
end

function M.eval(fnl, filename)
	local fennel = setup_compiler()

	local opts = get_compiler_opts(filename)

	local result = fennel.eval(fnl, opts)
	-- seperate eval prints from output
	print("\n")
	print_stdout(fennel.view(result))

	teardown()
end

function M.compile(fnl, filename)
	local fennel = setup_compiler()

	local opts = get_compiler_opts(filename)

	local lua = fennel.compileString(fnl, opts)
	print_stdout(lua)

	teardown()
end

function M.setup(user_opts)
	compiler_opts = user_opts
end

return M
