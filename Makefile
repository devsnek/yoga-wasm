CC=emcc

all: build/yoga.js build/index.js

build/yoga.js: build yoga/yoga/*.cpp yoga/yoga/**/*.cpp src/*.cc
	$(CC) yoga/yoga/*.cpp yoga/yoga/**/*.cpp src/*.cc \
		--bind -Os --memory-init-file 0 --llvm-lto 1 \
		-Iyoga \
		-fno-exceptions \
		-s WASM=1 \
		-s WASM_ASYNC_COMPILATION=0 \
		-s EXPORTED_RUNTIME_METHODS=[] \
		-s DISABLE_EXCEPTION_CATCHING=1 \
		-s AGGRESSIVE_VARIABLE_ELIMINATION=1 \
		-s NO_EXIT_RUNTIME=1 \
		-s ASSERTIONS=0 \
		-s ALLOW_MEMORY_GROWTH=1 \
		-s MODULARIZE=1 \
		-o build/yoga.js

build/index.js: build index.mjs
	./node_modules/.bin/rollup -c ./rollup.config.js

clean:
	rm -rf build

build:
	mkdir -p build

format:
	clang-format --style=chromium -i src/*.{cc,h}

.PHONY: format clean
