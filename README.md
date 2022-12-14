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
