all: gcc no-gcc 

gcc: gcc-no-opt gcc-opt

no-gcc: no-opt opt opt-asm

no-opt: src/rsa.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa.c -o bin/rsa

opt: src/rsa-opt.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt.c -o bin/rsa-opt

gcc-no-opt: src/rsa.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa.c -O3 -S -o bin/rsa-gcc.S
	gcc -std=c99 -Iinclude/ bin/rsa-gcc.S -o bin/rsa-gcc

gcc-opt: src/rsa-opt.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt.c -O3 -S -o bin/rsa-opt-gcc.S
	gcc -std=c99 -Iinclude/ bin/rsa-opt-gcc.S -o bin/rsa-opt-gcc

opt-asm: src/rsa-opt-asm.S include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa-opt-asm.S -o bin/rsa-opt-asm

hardware: src/mmm.v src/mmm_tb.v
    iverilog -o mmm bin/mmm_tb.v

clean: 
	rm bin/*
