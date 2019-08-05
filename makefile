all: no-opt opt opt-asm

no-opt: src/rsa.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa.c -o bin/rsa

opt: src/rsa-opt.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt.c -S -o bin/rsa-opt.S
	gcc -std=c99 -Iinclude/ bin/rsa-opt.S -o bin/rsa-opt

opt-asm: src/rsa-opt-asm.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt-asm.c -S -o bin/rsa-opt-asm.S
	gcc -std=c99 -Iinclude/ bin/rsa-opt-asm.S -o bin/rsa-opt-asm

clean: 
	rm bin/*
