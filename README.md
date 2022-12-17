# fnlnvim

This is a Fennel compiler that runs through Neovim.
All Neovim Lua APIs are available.

## Installation

With Packer:

```lua
use "ec965/fnlnvim"
```

## Setup

You can add compiler options using the setup function. 
This is not strictly necessary.
A list of compiler options is available in the [fennel documentation](https://fennel-lang.org/api).

```lua
require("fnlnvim").setup({
  -- compiler options
})
```

## User Commands

- `FnlNvimCompile` - compile a file and print its outputs to stdout
- `FnlNvimEval` - evaluate a file and print its outputs to stdout

## Headless Mode

Compile a file:

```bash
nvim --headless -c "FnlNvimCompile ${INPUT}" +q > $OUTPUT
```

Evaluate a file:

```bash
nvim --headless -c "FnlNvimEval ${INPUT}" +q
```

For a more ergonomic setup, you can wrap the shell commands in a script.
For example, I use a [python script](https://gist.github.com/ec965/bc1dd95aa31523e948e31ead5f9fdac5).
