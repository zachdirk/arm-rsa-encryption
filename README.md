# arm-rsa-encryption

This is my implementation of rsa-encryption optimized for arm processors for SENG440 in the UVic summer 2019 term. 

Relevant source files include:

- `include/rsa.h` - a header file containing typedefs and forward declarations
- `src/rsa.c` - this is the first implementation, completely unoptimized
- `src/rsa-opt.c` - this is the optimized c version
- `src/rsa-opt-asm-me.S` - this is the optimized assembly version

Build instructions: on an arm machine with make installed, simply run `make` to generate all the various build files. On any other machine with gcc you can still build but it's not necessarily going to give the results you want.

Relevant build files include:

- `bin/rsa` - this is the result of compiling `src/rsa.c`
- `bin/rsa-opt` - this is the result of compiling `src/rsa-opt.c`
- `bin/rsa-opt-asm` - this is the result of compiling `src/rsa-opt-asm-me.S`
- `bin/rsa-gcc` - this is the result of compiling `src/rsa.c` with GCC's O3 flag
- `bin/rsa-opt-gcc` - this is the result of compiling `src/rsa-opt.c` with GCC's O3 flag

Profiling instructions: on an arm machine with perf installed, simply run ./profile.sh {executable} i.e. `./profile.sh bin/rsa`

Other relevant files:

- `README.md` - that's this
- `profile.sh` - a basic shell script to run the perf command 3 times
- `report.tex` - a latex document containing the report for this project
- `Report.pdf` - the report generated from `report.tex`
