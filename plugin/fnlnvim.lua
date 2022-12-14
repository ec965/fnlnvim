local command = vim.api.nvim_create_user_command

local function read_file(input_file)
	assert(input_file, "Input file is missing!")
	local file_handle = assert(io.open(input_file))
	return file_handle:read("*a")
end

command("FnlNvimCompile", function(opts)
	local fnl = read_file(opts.args)
	local input_file = opts.args

	require("fnlnvim").compile(fnl, input_file)
end, { nargs = 1 })

command("FnlNvimEval", function(opts)
	local fnl = read_file(opts.args)
	local input_file = opts.args

	require("fnlnvim").eval(fnl, input_file)
end, { nargs = 1 })
