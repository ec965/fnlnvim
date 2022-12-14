local command = vim.api.nvim_create_user_command

command("FnlNvimCompile", function(opts)
	local input_file = opts.args
	assert(input_file, "Input file is missing!")

	require("fnlnvim").compile(input_file)
end, { nargs = 1 })

command("FnlNvimEval", function(opts)
	local input_file = opts.args
	assert(input_file, "Input file is missing!")

	local file_handle = assert(io.open(input_file))
	local fnl = file_handle:read("*a")

	require("fnlnvim").eval(fnl, input_file)
end, { nargs = 1 })
