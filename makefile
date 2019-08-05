all: 

gcc: gcc-no-opt gcc-opt

no-opt: src/rsa.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa.c -S -o bin/rsa.S
	gcc -std=c99 -Iinclude/ bin/rsa.S -o bin/rsa

opt: src/rsa-opt.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt.c -S -o bin/rsa-opt.S
	gcc -std=c99 -Iinclude/ bin/rsa-opt.S -o bin/rsa-opt

gcc-no-opt: src/rsa.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa.c -O3 -S -o bin/rsa-gcc.S
	gcc -std=c99 -Iinclude/ bin/rsa-gcc.S -o bin/rsa-gcc

gcc-opt: src/rsa-opt.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt.c -O3 -S -o bin/rsa-opt-gcc.S
	gcc -std=c99 -Iinclude/ bin/rsa-opt-gcc.S -o bin/rsa-opt-gcc

opt-asm: src/rsa-opt-asm.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt-asm.c -S -o bin/rsa-opt-asm.S
	gcc -std=c99 -Iinclude/ bin/rsa-opt-asm.S -o bin/rsa-opt-asm

asm: bin/rsa-opt-asm.S
	gcc -std=c99 -Iinclude/ bin/rsa-opt-asm.S -o bin/rsa-opt-asm

clean: 
	rm bin/*
