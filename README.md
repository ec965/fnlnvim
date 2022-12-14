# fnlnvim

This is a Fennel compiler that runs through Neovim.
All Neovim Lua APIs are available.

## Installation

With Packer:

```lua
use "ec965/fnlnvim"
```

## User Commands

- `FnlNvimCompile`
- `FnlNvimEval`

## Headless Mode

Compile a file:

```bash
nvim --headless -c "FnlNvimCompile ${INPUT}" +q > $OUTPUT
```

Evaluate a file:

```bash
nvim --headless -c "FnlNvimEval ${INPUT}" +q
```
