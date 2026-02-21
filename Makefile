FAILFAST ?= true

all: build

build: sonic-win
	@echo "Compiling"
	./compile.sh ${FAILFAST}

actions: sonic-win
	@echo "Compiling using CI scripts"
	./actionscompile.sh ${FAILFAST}

clean:
	./clean.sh

distclean:
	./distclean.sh

sonic-win: get

get:
	./download.sh

.PHONY: all clean distclean get # build is a real dir
