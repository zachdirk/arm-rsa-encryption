	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"rsa-opt-asm.c"
	.text
	.global	M_
	.data
	.align	3
	.type	M_, %object
	.size	M_, 8
M_:
	.word	-2063155181
	.word	8896677
	.global	E_
	.align	3
	.type	E_, %object
	.size	E_, 8
E_:
	.word	65537
	.word	0
	.global	D_
	.align	3
	.type	D_, %object
	.size	D_, 8
D_:
	.word	1782482161
	.word	7169524
	.text
	.align	2
	.global	count_bits
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	count_bits, %function
count_bits:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, fp}
	add	fp, sp, #4
	sub	sp, sp, #8
	strd	r0, [fp, #-12]
	mov	r4, #0
	b	.L2
.L3:
	add	r4, r4, #1
	ldrd	r0, [fp, #-12]
	lsr	r2, r0, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	strd	r2, [fp, #-12]
.L2:
	ldrd	r2, [fp, #-12]
	orrs	r3, r2, r3
	bne	.L3
	mov	r2, r4
	mov	r3, #0
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{r4, fp}
	bx	lr
	.size	count_bits, .-count_bits
	.global	__aeabi_uldivmod
	.align	2
	.global	integer_power
	.syntax unified
	.arm
	.fpu vfp
	.type	integer_power, %function
integer_power:
	@ args = 8, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #16
	strd	r0, [fp, #-28]
	strd	r2, [fp, #-36]
	mov	r4, #1
	mov	r5, #0
	b	.L6
.L7:
	ldr	r3, [fp, #-28]
	mul	r2, r5, r3
	ldr	r3, [fp, #-24]
	mul	r3, r4, r3
	add	r3, r2, r3
	ldr	r2, [fp, #-28]
	umull	r0, r1, r2, r4
	add	r1, r3, r1
	ldrd	r2, [fp, #4]
	bl	__aeabi_uldivmod
	mov	r4, r2
	mov	r5, r3
	ldrd	r2, [fp, #-36]
	subs	r2, r2, #1
	sbc	r7, r3, #0
	strd	r2, [fp, #-36]
.L6:
	orrs	r3, r2, r3
	bne	.L7
	mov	r2, r4
	mov	r3, r5
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
	.size	integer_power, .-integer_power
	.align	2
	.global	montgomery_modular_multiplication
	.syntax unified
	.arm
	.fpu vfp
	.type	montgomery_modular_multiplication, %function
montgomery_modular_multiplication:
	@ args = 12, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #36
	strd	r0, [fp, #-44]
	strd	r2, [fp, #-68]
	ldrd	r8, [fp, #4]
	ldr	ip, [fp, #12]
	mov	r4, #0
	mov	r5, #0
	and	lr, r2, #1
	b	.L10
.L11:
	ldr	r3, [fp, #-44]
	and	r6, r3, #1
	and	r2, r4, #1
	and	r3, r6, lr
	eor	r10, r2, r3
	mov	r2, r6
	ldrd	r6, [fp, #-68]
	mul	r1, r2, r7
	umull	r6, r7, r6, r2
	add	r7, r1, r7
	mul	r1, r10, r9
	umull	r2, r3, r8, r10
	add	r3, r1, r3
	adds	r2, r6, r2
	adc	r3, r7, r3
	adds	r1, r4, r2
	adc	r3, r5, r3
	lsr	r4, r1, #1
	orr	r4, r4, r3, lsl #31
	lsr	r5, r3, #1
	ldrd	r2, [fp, #-44]
	lsr	r0, r2, #1
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	strd	r0, [fp, #-44]
	sub	ip, ip, #1
.L10:
	cmp	ip, #0
	bne	.L11
	cmp	r5, r9
	cmpeq	r4, r8
	bcc	.L12
	subs	r4, r4, r8
	sbc	r5, r5, r9
.L12:
	mov	r2, r4
	mov	r3, r5
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #32
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	montgomery_modular_multiplication, .-montgomery_modular_multiplication
	.align	2
	.global	modular_exponentiation
	.syntax unified
	.arm
	.fpu vfp
	.type	modular_exponentiation, %function
modular_exponentiation:
	@ args = 12, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #44
	strd	r0, [fp, #-60]
	mov	r4, r2
	mov	r5, r3
	ldrd	r6, [fp, #4]
	ldr	r10, [fp, #12]
	lsl	r3, r10, #1
	mov	r2, r3
	mov	r3, #0
	strd	r6, [sp]
	mov	r0, #2
	mov	r1, #0
	bl	integer_power
	mov	r8, r0
	mov	r9, r1
	str	r10, [sp, #8]
	strd	r6, [sp]
	mov	r2, r8
	mov	r3, r9
	mov	r0, #1
	mov	r1, #0
	bl	montgomery_modular_multiplication
	strd	r0, [fp, #-44]
	str	r10, [sp, #8]
	strd	r6, [sp]
	mov	r2, r8
	mov	r3, r9
	ldrd	r0, [fp, #-60]
	bl	montgomery_modular_multiplication
	mov	r8, r0
	mov	r9, r1
	b	.L15
.L17:
	mov	r2, #1
	mov	r3, #0
	and	r1, r4, r2
	str	r1, [fp, #-52]
	str	r3, [fp, #-48]
	ldrd	r2, [fp, #-52]
	orrs	r3, r2, r3
	beq	.L16
	str	r10, [sp, #8]
	strd	r6, [sp]
	mov	r2, r8
	mov	r3, r9
	ldrd	r0, [fp, #-44]
	bl	montgomery_modular_multiplication
	strd	r0, [fp, #-44]
.L16:
	str	r10, [sp, #8]
	strd	r6, [sp]
	mov	r2, r8
	mov	r3, r9
	mov	r0, r8
	mov	r1, r9
	bl	montgomery_modular_multiplication
	mov	r8, r0
	mov	r9, r1
	lsr	r2, r4, #1
	orr	r2, r2, r5, lsl #31
	lsr	r3, r5, #1
	mov	r4, r2
	mov	r5, r3
.L15:
	orrs	r3, r4, r5
	bne	.L17
	str	r10, [sp, #8]
	strd	r6, [sp]
	ldrd	r2, [fp, #-44]
	mov	r0, #1
	mov	r1, #0
	bl	montgomery_modular_multiplication
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #32
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	modular_exponentiation, .-modular_exponentiation
	.align	2
	.global	encrypt
	.syntax unified
	.arm
	.fpu vfp
	.type	encrypt, %function
encrypt:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #24
	strd	r0, [fp, #-28]
	ldr	r3, .L21
	ldrd	r6, [r3]
	ldr	r3, .L21+4
	ldrd	r4, [r3]
	ldr	r3, .L21+4
	ldrd	r2, [r3]
	mov	r0, r2
	mov	r1, r3
	bl	count_bits
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	str	r3, [sp, #8]
	strd	r4, [sp]
	mov	r2, r6
	mov	r3, r7
	ldrd	r0, [fp, #-28]
	bl	modular_exponentiation
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L22:
	.align	2
.L21:
	.word	E_
	.word	M_
	.size	encrypt, .-encrypt
	.align	2
	.global	decrypt
	.syntax unified
	.arm
	.fpu vfp
	.type	decrypt, %function
decrypt:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #24
	strd	r0, [fp, #-28]
	ldr	r3, .L25
	ldrd	r6, [r3]
	ldr	r3, .L25+4
	ldrd	r4, [r3]
	ldr	r3, .L25+4
	ldrd	r2, [r3]
	mov	r0, r2
	mov	r1, r3
	bl	count_bits
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	str	r3, [sp, #8]
	strd	r4, [sp]
	mov	r2, r6
	mov	r3, r7
	ldrd	r0, [fp, #-28]
	bl	modular_exponentiation
	mov	r2, r0
	mov	r3, r1
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
.L26:
	.align	2
.L25:
	.word	D_
	.word	M_
	.size	decrypt, .-decrypt
	.section	.rodata
	.align	2
.LC0:
	.ascii	"src/rsa-opt-asm.c\000"
	.align	2
.LC1:
	.ascii	"msg == d\000"
	.text
	.align	2
	.global	profile
	.syntax unified
	.arm
	.fpu vfp
	.type	profile, %function
profile:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	mov	r0, #0
	bl	srand
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L28
.L30:
	bl	rand
	mov	r3, r0
	mov	r2, r3
	asr	r3, r2, #31
	strd	r2, [fp, #-20]
	ldrd	r0, [fp, #-20]
	bl	encrypt
	strd	r0, [fp, #-28]
	ldrd	r0, [fp, #-28]
	bl	decrypt
	strd	r0, [fp, #-36]
	ldrd	r0, [fp, #-20]
	ldrd	r2, [fp, #-36]
	cmp	r1, r3
	cmpeq	r0, r2
	beq	.L29
	ldr	r3, .L31
	mov	r2, #115
	ldr	r1, .L31+4
	ldr	r0, .L31+8
	bl	__assert_fail
.L29:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L28:
	ldr	r3, [fp, #-8]
	cmp	r3, #1000
	blt	.L30
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L32:
	.align	2
.L31:
	.word	__PRETTY_FUNCTION__.6773
	.word	.LC0
	.word	.LC1
	.size	profile, .-profile
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	bl	profile
	mov	r3, #0
	mov	r0, r3
	pop	{fp, pc}
	.size	main, .-main
	.section	.rodata
	.align	2
	.type	__PRETTY_FUNCTION__.6773, %object
	.size	__PRETTY_FUNCTION__.6773, 8
__PRETTY_FUNCTION__.6773:
	.ascii	"profile\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
