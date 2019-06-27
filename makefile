gcc: src/rsa.c include/rsa.h
	gcc -I/include/ src/rsa.c -o bin/rsa

arm: src/rsa.c include/rsa.h
	cp src/rsa.c /tmp/rsa.c
	cd /tmp/; arm-linux-gcc -I/include/ -static -o ~/SENG440/rsa/bin/rsa.exe rsa.c

clean: 
	rm bin/*
