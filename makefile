gcc: src/rsa.c include/rsa.h
	gcc -std=c99 -Iinclude/ src/rsa.c -lm -o bin/rsa

arm: src/rsa.c include/rsa.h
	cp src/rsa.c /tmp/rsa.c
	cp include/rsa.h /tmp/rsa.h
	cd /tmp/; arm-linux-gcc -std=c99 -lm -static -o ~/SENG440/rsa/bin/rsa.exe rsa.c

clean: 
	rm bin/*
