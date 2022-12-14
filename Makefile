SHELL := /bin/bash

FNL_FILES := $(shell find . -name '*.fnl' -type f | sort)

.PHONY: all
all: doc/fnlnvim.txt fmt

# format lua and fennel files
.PHONY: fmt
fmt:
	stylua .; $(foreach file,$(FNL_FILES),echo "Formatting " $(file); fnlfmt --fix $(file);)

# update fennel version to latest
.PHONY: update_fennel
update_fennel:
	./update_fennel.sh

doc/fnlnvim.txt: README.md
	md2vim $< $@
