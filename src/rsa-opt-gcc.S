	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"rsa-opt.c"
	.text
	.align	2
	.global	count_bits
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	count_bits, %function
count_bits:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	orrs	r3, r0, r1
	beq	.L4
	mov	r2, #0
.L3:
	lsr	r3, r0, #1
	orr	r3, r3, r1, lsl #31
	lsr	ip, r1, #1
	mov	r0, r3
	mov	r1, ip
	orrs	r3, r0, r1
	add	r2, r2, #1
	bne	.L3
	mov	r0, r2
	mov	r1, #0
	bx	lr
.L4:
	mov	r0, #0
	mov	r1, #0
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
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r4, r2
	mov	r5, r3
	orrs	r3, r4, r5
	beq	.L10
	mov	r8, r0
	mov	r9, r1
	mov	r2, #1
	mov	r3, #0
.L9:
	mul	r1, r8, r3
	umull	r6, r7, r8, r2
	mla	r1, r2, r9, r1
	mov	r0, r6
	add	r7, r1, r7
	ldrd	r2, [sp, #32]
	mov	r1, r7
	bl	__aeabi_uldivmod
	subs	r4, r4, #1
	sbc	r5, r5, #0
	orrs	r1, r4, r5
	bne	.L9
.L7:
	mov	r0, r2
	mov	r1, r3
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L10:
	mov	r2, #1
	mov	r3, #0
	b	.L7
	.size	integer_power, .-integer_power
	.align	2
	.global	montgomery_modular_multiplication
	.syntax unified
	.arm
	.fpu vfp
	.type	montgomery_modular_multiplication, %function
montgomery_modular_multiplication:
	@ args = 12, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r4, #0
	ldr	ip, [sp, #44]
	mov	r5, #0
	cmp	ip, #0
	ldrd	r10, [sp, #36]
	beq	.L14
.L15:
	and	lr, r0, #1
	and	r6, r2, lr
	and	ip, r4, #1
	umull	r8, r9, lr, r2
	eor	ip, ip, r6
	mla	r9, lr, r3, r9
	umull	r6, r7, ip, r10
	adds	lr, r8, r4
	mla	r7, ip, fp, r7
	adc	ip, r9, r5
	adds	lr, r6, lr
	adc	ip, r7, ip
	lsr	r4, lr, #1
	ldr	lr, [sp, #44]
	lsr	r0, r0, #1
	subs	lr, lr, #1
	orr	r0, r0, r1, lsl #31
	str	lr, [sp, #44]
	orr	r4, r4, ip, lsl #31
	lsr	r5, ip, #1
	lsr	r1, r1, #1
	bne	.L15
.L14:
	cmp	fp, r5
	cmpeq	r10, r4
	bhi	.L13
	subs	r4, r4, r10
	sbc	r5, r5, fp
.L13:
	mov	r0, r4
	mov	r1, r5
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	montgomery_modular_multiplication, .-montgomery_modular_multiplication
	.align	2
	.global	modular_exponentiation
	.syntax unified
	.arm
	.fpu vfp
	.type	modular_exponentiation, %function
modular_exponentiation:
	@ args = 12, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #44
	mov	r10, r1
	ldr	r1, [sp, #88]
	mov	r8, r0
	strd	r2, [sp, #8]
	lsl	r4, r1, #1
	cmp	r4, #0
	beq	.L46
	ldrd	r6, [sp, #80]
	mov	r5, #0
	mov	r2, #1
	mov	r3, #0
.L22:
	adds	r0, r2, r2
	adc	r1, r3, r3
	mov	r2, r6
	mov	r3, r7
	bl	__aeabi_uldivmod
	subs	r4, r4, #1
	sbc	r5, r5, #0
	orrs	r1, r4, r5
	bne	.L22
	ldr	r1, [sp, #88]
	mov	fp, r2
	cmp	r1, #0
	beq	.L23
.L71:
	mov	r4, #1
	str	fp, [sp, #32]
	str	r10, [sp, #36]
	ldrd	r10, [sp, #80]
	mov	r0, r4
	mov	ip, #0
	mov	r9, r1
	mov	r4, #0
	mov	r5, #0
.L24:
	ldr	r1, [sp, #32]
	and	lr, r4, #1
	and	r1, r1, r0
	eor	lr, lr, r1
	mul	r1, r0, r3
	umull	r6, r7, lr, r10
	mla	ip, ip, r2, r1
	umull	r0, r1, r0, r2
	mla	r7, lr, fp, r7
	strd	r0, [sp]
	add	r1, ip, r1
	str	r1, [sp, #4]
	ldr	r1, [sp]
	adds	r0, r1, r4
	ldr	r1, [sp, #4]
	adc	r1, r1, r5
	adds	r0, r6, r0
	adc	r1, r7, r1
	lsr	r4, r0, #1
	subs	r9, r9, #1
	mov	r0, #0
	orr	r4, r4, r1, lsl #31
	lsr	r5, r1, #1
	mov	ip, r0
	bne	.L24
	ldrd	r0, [sp, #80]
	strd	r4, [sp, #24]
	ldr	fp, [sp, #32]
	cmp	r1, r5
	cmpeq	r0, r4
	ldr	r10, [sp, #36]
	bhi	.L43
	ldr	r1, [sp, #24]
	ldr	r0, [sp, #80]
	subs	r1, r1, r0
	str	r1, [sp, #24]
	ldr	r0, [sp, #84]
	ldr	r1, [sp, #28]
	sbc	r1, r1, r0
	str	r1, [sp, #28]
.L43:
	ldr	r9, [sp, #88]
	mov	r6, #0
	mov	r7, #0
.L26:
	and	lr, r8, #1
	and	r1, lr, fp
	and	ip, r6, #1
	eor	ip, ip, r1
	umull	r4, r5, lr, r2
	ldr	r1, [sp, #80]
	mla	r5, lr, r3, r5
	umull	r0, r1, ip, r1
	ldr	lr, [sp, #84]
	lsr	r8, r8, #1
	orr	r8, r8, r10, lsl #31
	mla	r1, ip, lr, r1
	adds	lr, r4, r6
	adc	ip, r5, r7
	adds	lr, r0, lr
	adc	r1, r1, ip
	lsr	r6, lr, #1
	subs	r9, r9, #1
	orr	r6, r6, r1, lsl #31
	lsr	r7, r1, #1
	lsr	r10, r10, #1
	bne	.L26
.L45:
	ldrd	r2, [sp, #80]
	cmp	r3, r7
	cmpeq	r2, r6
	bls	.L44
.L27:
	ldrd	r2, [sp, #8]
	orrs	r3, r2, r3
	beq	.L28
.L36:
	ldr	r3, [sp, #8]
	mov	fp, r6
	and	r3, r3, #1
	str	r3, [sp, #16]
	mov	r3, #0
	str	r3, [sp, #20]
	ldrd	r2, [sp, #16]
	orrs	r3, r2, r3
	bne	.L69
	ldr	r3, [sp, #88]
	cmp	r3, #0
	beq	.L47
.L41:
	ldr	r10, [sp, #88]
	mov	ip, r6
	mov	r2, #0
	mov	r3, #0
	mov	lr, r7
	mov	r9, fp
.L34:
	and	r8, ip, #1
	and	r1, r2, #1
	umull	r4, r5, r8, r6
	and	r0, r8, r9
	eor	fp, r1, r0
	ldr	r1, [sp, #80]
	strd	r4, [sp]
	mla	r4, r8, r7, r5
	umull	r0, r1, fp, r1
	str	r4, [sp, #4]
	ldr	r4, [sp, #84]
	ldr	r5, [sp, #4]
	lsr	ip, ip, #1
	mla	r1, fp, r4, r1
	ldr	r4, [sp]
	orr	ip, ip, lr, lsl #31
	adds	r4, r4, r2
	adc	r3, r5, r3
	adds	r4, r0, r4
	adc	r1, r1, r3
	lsr	r2, r4, #1
	subs	r10, r10, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	lsr	lr, lr, #1
	bne	.L34
.L33:
	ldrd	r0, [sp, #80]
	cmp	r1, r3
	cmpeq	r0, r2
	bhi	.L35
	ldr	r1, [sp, #80]
	subs	r2, r2, r1
	ldr	r1, [sp, #84]
	sbc	r3, r3, r1
.L35:
	ldrd	r4, [sp, #8]
	mov	r6, r2
	mov	r7, r3
	lsr	r1, r4, #1
	orr	r1, r1, r5, lsl #31
	lsr	r0, r5, #1
	str	r1, [sp, #8]
	str	r0, [sp, #12]
	ldrd	r0, [sp, #8]
	orrs	r1, r0, r1
	bne	.L36
.L28:
	ldr	r3, [sp, #88]
	ldrd	r8, [sp, #24]
	cmp	r3, #0
	mov	r0, #0
	mov	r1, #0
	mov	r6, r8
	beq	.L37
	ldrd	r10, [sp, #80]
	mov	r2, #1
	mov	ip, #0
	mov	r7, r3
.L38:
	mul	ip, r8, ip
	and	r3, r6, r2
	and	lr, r0, #1
	eor	lr, lr, r3
	mla	ip, r2, r9, ip
	umull	r2, r3, r8, r2
	umull	r4, r5, lr, r10
	strd	r2, [sp]
	add	r3, ip, r3
	str	r3, [sp, #4]
	ldr	r3, [sp]
	mla	r5, lr, fp, r5
	adds	r2, r3, r0
	ldr	r3, [sp, #4]
	adc	r3, r3, r1
	adds	r2, r4, r2
	adc	r3, r5, r3
	lsr	r0, r2, #1
	subs	r7, r7, #1
	mov	r2, #0
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	mov	ip, r2
	bne	.L38
.L37:
	ldrd	r2, [sp, #80]
	cmp	r3, r1
	cmpeq	r2, r0
	bhi	.L20
	ldr	r3, [sp, #80]
	subs	r0, r0, r3
	ldr	r3, [sp, #84]
	sbc	r1, r1, r3
.L20:
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L69:
	ldr	r3, [sp, #88]
	cmp	r3, #0
	beq	.L30
	mov	r8, r3
	ldrd	r0, [sp, #24]
	mov	r2, #0
	mov	r3, #0
	mov	lr, r8
	mov	r9, r6
.L31:
	and	r8, r0, #1
	and	r4, r8, r9
	umull	r10, fp, r8, r6
	and	ip, r2, #1
	eor	ip, ip, r4
	ldr	r4, [sp, #80]
	mla	r8, r8, r7, fp
	umull	r4, r5, ip, r4
	strd	r10, [sp]
	str	r8, [sp, #4]
	ldr	r8, [sp, #84]
	mla	r5, ip, r8, r5
	ldr	ip, [sp]
	adds	r10, ip, r2
	ldr	ip, [sp, #4]
	adc	ip, ip, r3
	adds	r10, r4, r10
	adc	ip, r5, ip
	lsr	r4, r0, #1
	orr	r4, r4, r1, lsl #31
	lsr	r2, r10, #1
	lsr	r5, r1, #1
	subs	lr, lr, #1
	orr	r2, r2, ip, lsl #31
	mov	r0, r4
	lsr	r3, ip, #1
	mov	r1, r5
	bne	.L31
	strd	r0, [sp, #24]
	ldrd	r0, [sp, #80]
	mov	fp, r9
	cmp	r1, r3
	cmpeq	r0, r2
	strdhi	r2, [sp, #24]
	bhi	.L41
.L40:
	ldr	r1, [sp, #80]
	subs	r1, r2, r1
	str	r1, [sp, #24]
	ldr	r1, [sp, #84]
	sbc	r3, r3, r1
	str	r3, [sp, #28]
	ldr	r3, [sp, #88]
	cmp	r3, #0
	bne	.L41
.L47:
	mov	r2, #0
	mov	r3, #0
	b	.L33
.L50:
	ldrd	r2, [sp, #80]
	mov	r6, r2
	mov	r7, r3
	strd	r2, [sp, #24]
.L44:
	ldr	r3, [sp, #80]
	subs	r6, r6, r3
	ldr	r3, [sp, #84]
	sbc	r7, r7, r3
	b	.L27
.L30:
	ldrd	r2, [sp, #80]
	orrs	r3, r2, r3
	ldrdeq	r2, [sp, #80]
	beq	.L40
.L70:
	mov	r2, #0
	mov	r3, #0
	strd	r2, [sp, #24]
	b	.L33
.L46:
	ldr	r1, [sp, #88]
	mov	fp, #1
	cmp	r1, #0
	mov	r2, fp
	mov	r3, #0
	bne	.L71
.L23:
	ldrd	r2, [sp, #80]
	orrs	r3, r2, r3
	beq	.L50
	mov	r2, #0
	mov	r3, #0
	mov	r6, r2
	strd	r2, [sp, #24]
	mov	r7, r3
	b	.L45
	.size	modular_exponentiation, .-modular_exponentiation
	.align	2
	.global	encrypt
	.syntax unified
	.arm
	.fpu vfp
	.type	encrypt, %function
encrypt:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L128
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r5, r0
	mov	r8, r1
	ldrd	r0, [r3, #8]
	ldrd	r2, [r3]
	sub	sp, sp, #68
	strd	r2, [sp, #8]
	orrs	r3, r0, r1
	strd	r0, [sp]
	beq	.L73
	mov	r10, r0
	mov	fp, r1
	mov	r4, #0
.L74:
	lsr	r3, r10, #1
	orr	r3, r3, fp, lsl #31
	lsr	r2, fp, #1
	mov	r10, r3
	mov	fp, r2
	orrs	r3, r10, fp
	add	r4, r4, #1
	bne	.L74
	lsl	r6, r4, #1
	cmp	r6, #0
	mov	r7, #0
	beq	.L100
	strd	r10, [sp, #16]
	mov	r9, r4
	mov	fp, r8
	mov	r8, r5
	ldrd	r4, [sp]
	mov	r2, #1
	mov	r3, #0
.L76:
	adds	r0, r2, r2
	adc	r1, r3, r3
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_uldivmod
	subs	r6, r6, #1
	sbc	r7, r7, #0
	orrs	r1, r6, r7
	bne	.L76
	mov	r5, r8
	mov	r8, fp
	ldrd	r10, [sp, #16]
	mov	r4, r9
	str	r2, [sp, #24]
.L75:
	cmp	r4, #0
	beq	.L101
	mov	r6, #0
	mov	r7, #0
	str	r8, [sp, #60]
	mov	r8, r3
	ldr	r3, [sp, #24]
	mov	lr, r4
	str	r4, [sp, #44]
	str	r5, [sp, #56]
	mov	r0, #1
	mov	r1, #0
	mov	r4, r6
	mov	r5, r7
.L78:
	mul	r9, r0, r8
	and	r6, r4, #1
	and	ip, r3, r0
	mla	r9, r1, r2, r9
	umull	r0, r1, r0, r2
	eor	ip, ip, r6
	ldr	r6, [sp]
	strd	r0, [sp, #16]
	ldr	r1, [sp, #4]
	umull	r6, r7, ip, r6
	mla	r7, ip, r1, r7
	ldr	r1, [sp, #20]
	add	r1, r9, r1
	str	r1, [sp, #20]
	ldr	r1, [sp, #16]
	adds	r0, r1, r4
	ldr	r1, [sp, #20]
	adc	r1, r1, r5
	adds	r0, r6, r0
	adc	r1, r7, r1
	lsr	r4, r0, #1
	subs	lr, lr, #1
	orr	r4, r4, r1, lsl #31
	lsr	r5, r1, #1
	mov	r0, r10
	mov	r1, fp
	bne	.L78
	strd	r4, [sp, #48]
	ldrd	r0, [sp]
	ldrd	r6, [sp, #48]
	mov	r3, r8
	ldr	r4, [sp, #44]
	cmp	r1, r7
	cmpeq	r0, r6
	ldr	r5, [sp, #56]
	ldr	r8, [sp, #60]
	bls	.L125
.L99:
	mov	r9, r4
	str	r4, [sp, #16]
	mov	r4, r3
	ldr	r3, [sp, #24]
.L82:
	and	lr, r5, #1
	and	r1, lr, r3
	and	ip, r10, #1
	eor	ip, ip, r1
	umull	r6, r7, lr, r2
	ldr	r1, [sp]
	mla	r7, lr, r4, r7
	umull	r0, r1, ip, r1
	ldr	lr, [sp, #4]
	lsr	r5, r5, #1
	orr	r5, r5, r8, lsl #31
	mla	r1, ip, lr, r1
	adds	ip, r6, r10
	adc	lr, r7, fp
	adds	ip, r0, ip
	adc	r1, r1, lr
	lsr	r10, ip, #1
	subs	r9, r9, #1
	orr	r10, r10, r1, lsl #31
	lsr	fp, r1, #1
	lsr	r8, r8, #1
	bne	.L82
	ldr	r4, [sp, #16]
.L77:
	ldrd	r2, [sp]
	cmp	r3, fp
	cmpeq	r2, r10
	bls	.L126
.L83:
	ldrd	r2, [sp, #8]
	orrs	r3, r2, r3
	beq	.L84
.L80:
	str	r4, [sp, #44]
.L92:
	ldr	r3, [sp, #8]
	mov	ip, r10
	and	r3, r3, #1
	str	r3, [sp, #32]
	mov	r3, #0
	str	r3, [sp, #36]
	ldrd	r2, [sp, #32]
	orrs	r3, r2, r3
	bne	.L127
	ldr	r3, [sp, #44]
	cmp	r3, #0
	beq	.L103
.L97:
	ldr	r4, [sp, #44]
	mov	lr, r10
	mov	r2, #0
	mov	r3, #0
	mov	r5, fp
.L90:
	and	r9, lr, #1
	and	r0, r9, ip
	and	r1, r2, #1
	eor	r8, r1, r0
	umull	r0, r1, r9, r10
	mov	r6, r0
	mov	r7, r1
	ldrd	r0, [sp]
	mla	r9, r9, fp, r7
	strd	r0, [sp, #24]
	ldr	r1, [sp, #24]
	strd	r6, [sp, #16]
	ldr	r6, [sp, #28]
	umull	r0, r1, r8, r1
	str	r9, [sp, #20]
	mla	r1, r8, r6, r1
	ldrd	r8, [sp, #16]
	lsr	lr, lr, #1
	orr	lr, lr, r5, lsl #31
	adds	r6, r8, r2
	adc	r3, r9, r3
	adds	r6, r0, r6
	adc	r1, r1, r3
	lsr	r2, r6, #1
	subs	r4, r4, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	lsr	r5, r5, #1
	bne	.L90
.L89:
	ldrd	r0, [sp]
	cmp	r1, r3
	cmpeq	r0, r2
	bhi	.L91
	subs	r2, r2, r0
	sbc	r3, r3, r1
.L91:
	ldrd	r4, [sp, #8]
	mov	r10, r2
	mov	fp, r3
	lsr	r1, r4, #1
	orr	r1, r1, r5, lsl #31
	lsr	r0, r5, #1
	str	r1, [sp, #8]
	str	r0, [sp, #12]
	ldrd	r0, [sp, #8]
	orrs	r1, r0, r1
	bne	.L92
	ldr	r4, [sp, #44]
.L84:
	ldrd	r8, [sp, #48]
	cmp	r4, #0
	mov	r5, r8
	beq	.L104
	ldrd	r10, [sp]
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	mov	r3, #0
.L94:
	and	lr, r0, #1
	and	ip, r5, r2
	eor	ip, ip, lr
	mul	lr, r2, r9
	umull	r6, r7, ip, r10
	mla	lr, r3, r8, lr
	umull	r2, r3, r2, r8
	mla	r7, ip, fp, r7
	strd	r2, [sp, #8]
	add	r3, lr, r3
	str	r3, [sp, #12]
	ldr	r3, [sp, #8]
	adds	r2, r3, r0
	ldr	r3, [sp, #12]
	adc	r3, r3, r1
	adds	r2, r6, r2
	adc	r3, r7, r3
	lsr	r0, r2, #1
	subs	r4, r4, #1
	mov	r2, #0
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	mov	r3, r2
	bne	.L94
	strd	r0, [sp, #8]
.L93:
	ldrd	r2, [sp]
	cmp	r3, r1
	cmpeq	r2, r0
	bls	.L81
	ldrd	r0, [sp, #8]
	add	sp, sp, #68
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L73:
	ldrd	r2, [sp, #8]
	orrs	r3, r2, r3
	movne	r10, r0
	movne	fp, r1
	movne	r4, #0
	strdne	r10, [sp, #48]
	bne	.L80
.L81:
	ldrd	r2, [sp]
	ldr	r1, [sp, #8]
	subs	r1, r1, r2
	str	r1, [sp, #8]
	ldr	r1, [sp, #12]
	sbc	r3, r1, r3
	str	r3, [sp, #12]
	ldrd	r0, [sp, #8]
	add	sp, sp, #68
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L127:
	ldr	r3, [sp, #44]
	cmp	r3, #0
	beq	.L86
	mov	r8, r3
	ldrd	r0, [sp, #48]
	mov	r2, #0
	mov	r3, #0
	mov	ip, r8
	str	r10, [sp, #24]
.L87:
	ldr	lr, [sp, #24]
	and	r8, r0, #1
	and	r4, r8, lr
	and	lr, r2, #1
	eor	lr, lr, r4
	umull	r4, r5, r8, r10
	ldrd	r6, [sp]
	strd	r4, [sp, #16]
	ldr	r9, [sp, #20]
	umull	r4, r5, lr, r6
	mla	r8, r8, fp, r9
	mla	r5, lr, r7, r5
	str	r8, [sp, #20]
	ldrd	r8, [sp, #16]
	adds	r6, r8, r2
	adc	lr, r9, r3
	adds	r6, r4, r6
	adc	lr, r5, lr
	lsr	r4, r0, #1
	orr	r4, r4, r1, lsl #31
	lsr	r2, r6, #1
	lsr	r5, r1, #1
	subs	ip, ip, #1
	orr	r2, r2, lr, lsl #31
	mov	r0, r4
	lsr	r3, lr, #1
	mov	r1, r5
	bne	.L87
	strd	r0, [sp, #48]
	ldrd	r0, [sp]
	ldr	ip, [sp, #24]
	cmp	r1, r3
	cmpeq	r0, r2
	strdhi	r2, [sp, #48]
	bhi	.L97
.L96:
	ldrd	r0, [sp]
	subs	lr, r2, r0
	sbc	r3, r3, r1
	str	r3, [sp, #52]
	ldr	r3, [sp, #44]
	str	lr, [sp, #48]
	cmp	r3, #0
	bne	.L97
.L103:
	mov	r2, #0
	mov	r3, #0
	b	.L89
.L125:
	ldr	ip, [sp, #48]
	subs	ip, ip, r0
	str	ip, [sp, #48]
	ldr	ip, [sp, #52]
	sbc	r1, ip, r1
	str	r1, [sp, #52]
	b	.L99
.L126:
	subs	r10, r10, r2
	sbc	fp, fp, r3
	b	.L83
.L86:
	ldrd	r2, [sp]
	orrs	r3, r2, r3
	movne	r2, #0
	movne	r3, #0
	strdne	r2, [sp, #48]
	bne	.L89
.L105:
	ldrd	r2, [sp]
	b	.L96
.L104:
	mov	r2, #0
	mov	r3, #0
	mov	r0, r2
	strd	r2, [sp, #8]
	mov	r1, r3
	b	.L93
.L100:
	mov	r3, #1
	str	r3, [sp, #24]
	mov	r2, r3
	mov	r3, #0
	b	.L75
.L101:
	mov	r2, #0
	mov	r3, #0
	strd	r2, [sp, #48]
	b	.L77
.L129:
	.align	2
.L128:
	.word	.LANCHOR0
	.size	encrypt, .-encrypt
	.align	2
	.global	decrypt
	.syntax unified
	.arm
	.fpu vfp
	.type	decrypt, %function
decrypt:
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L186
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r5, r0
	mov	r8, r1
	ldrd	r0, [r3, #8]
	ldrd	r2, [r3, #16]
	sub	sp, sp, #68
	strd	r2, [sp, #8]
	orrs	r3, r0, r1
	strd	r0, [sp]
	beq	.L131
	mov	r10, r0
	mov	fp, r1
	mov	r4, #0
.L132:
	lsr	r3, r10, #1
	orr	r3, r3, fp, lsl #31
	lsr	r2, fp, #1
	mov	r10, r3
	mov	fp, r2
	orrs	r3, r10, fp
	add	r4, r4, #1
	bne	.L132
	lsl	r6, r4, #1
	cmp	r6, #0
	mov	r7, #0
	beq	.L158
	strd	r10, [sp, #16]
	mov	r9, r4
	mov	fp, r8
	mov	r8, r5
	ldrd	r4, [sp]
	mov	r2, #1
	mov	r3, #0
.L134:
	adds	r0, r2, r2
	adc	r1, r3, r3
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_uldivmod
	subs	r6, r6, #1
	sbc	r7, r7, #0
	orrs	r1, r6, r7
	bne	.L134
	mov	r5, r8
	mov	r8, fp
	ldrd	r10, [sp, #16]
	mov	r4, r9
	str	r2, [sp, #24]
.L133:
	cmp	r4, #0
	beq	.L159
	mov	r6, #0
	mov	r7, #0
	str	r8, [sp, #60]
	mov	r8, r3
	ldr	r3, [sp, #24]
	mov	lr, r4
	str	r4, [sp, #44]
	str	r5, [sp, #56]
	mov	r0, #1
	mov	r1, #0
	mov	r4, r6
	mov	r5, r7
.L136:
	mul	r9, r0, r8
	and	r6, r4, #1
	and	ip, r3, r0
	mla	r9, r1, r2, r9
	umull	r0, r1, r0, r2
	eor	ip, ip, r6
	ldr	r6, [sp]
	strd	r0, [sp, #16]
	ldr	r1, [sp, #4]
	umull	r6, r7, ip, r6
	mla	r7, ip, r1, r7
	ldr	r1, [sp, #20]
	add	r1, r9, r1
	str	r1, [sp, #20]
	ldr	r1, [sp, #16]
	adds	r0, r1, r4
	ldr	r1, [sp, #20]
	adc	r1, r1, r5
	adds	r0, r6, r0
	adc	r1, r7, r1
	lsr	r4, r0, #1
	subs	lr, lr, #1
	orr	r4, r4, r1, lsl #31
	lsr	r5, r1, #1
	mov	r0, r10
	mov	r1, fp
	bne	.L136
	strd	r4, [sp, #48]
	ldrd	r0, [sp]
	ldrd	r6, [sp, #48]
	mov	r3, r8
	ldr	r4, [sp, #44]
	cmp	r1, r7
	cmpeq	r0, r6
	ldr	r5, [sp, #56]
	ldr	r8, [sp, #60]
	bls	.L183
.L157:
	mov	r9, r4
	str	r4, [sp, #16]
	mov	r4, r3
	ldr	r3, [sp, #24]
.L140:
	and	lr, r5, #1
	and	r1, lr, r3
	and	ip, r10, #1
	eor	ip, ip, r1
	umull	r6, r7, lr, r2
	ldr	r1, [sp]
	mla	r7, lr, r4, r7
	umull	r0, r1, ip, r1
	ldr	lr, [sp, #4]
	lsr	r5, r5, #1
	orr	r5, r5, r8, lsl #31
	mla	r1, ip, lr, r1
	adds	ip, r6, r10
	adc	lr, r7, fp
	adds	ip, r0, ip
	adc	r1, r1, lr
	lsr	r10, ip, #1
	subs	r9, r9, #1
	orr	r10, r10, r1, lsl #31
	lsr	fp, r1, #1
	lsr	r8, r8, #1
	bne	.L140
	ldr	r4, [sp, #16]
.L135:
	ldrd	r2, [sp]
	cmp	r3, fp
	cmpeq	r2, r10
	bls	.L184
.L141:
	ldrd	r2, [sp, #8]
	orrs	r3, r2, r3
	beq	.L142
.L138:
	str	r4, [sp, #44]
.L150:
	ldr	r3, [sp, #8]
	mov	ip, r10
	and	r3, r3, #1
	str	r3, [sp, #32]
	mov	r3, #0
	str	r3, [sp, #36]
	ldrd	r2, [sp, #32]
	orrs	r3, r2, r3
	bne	.L185
	ldr	r3, [sp, #44]
	cmp	r3, #0
	beq	.L161
.L155:
	ldr	r4, [sp, #44]
	mov	lr, r10
	mov	r2, #0
	mov	r3, #0
	mov	r5, fp
.L148:
	and	r9, lr, #1
	and	r0, r9, ip
	and	r1, r2, #1
	eor	r8, r1, r0
	umull	r0, r1, r9, r10
	mov	r6, r0
	mov	r7, r1
	ldrd	r0, [sp]
	mla	r9, r9, fp, r7
	strd	r0, [sp, #24]
	ldr	r1, [sp, #24]
	strd	r6, [sp, #16]
	ldr	r6, [sp, #28]
	umull	r0, r1, r8, r1
	str	r9, [sp, #20]
	mla	r1, r8, r6, r1
	ldrd	r8, [sp, #16]
	lsr	lr, lr, #1
	orr	lr, lr, r5, lsl #31
	adds	r6, r8, r2
	adc	r3, r9, r3
	adds	r6, r0, r6
	adc	r1, r1, r3
	lsr	r2, r6, #1
	subs	r4, r4, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	lsr	r5, r5, #1
	bne	.L148
.L147:
	ldrd	r0, [sp]
	cmp	r1, r3
	cmpeq	r0, r2
	bhi	.L149
	subs	r2, r2, r0
	sbc	r3, r3, r1
.L149:
	ldrd	r4, [sp, #8]
	mov	r10, r2
	mov	fp, r3
	lsr	r1, r4, #1
	orr	r1, r1, r5, lsl #31
	lsr	r0, r5, #1
	str	r1, [sp, #8]
	str	r0, [sp, #12]
	ldrd	r0, [sp, #8]
	orrs	r1, r0, r1
	bne	.L150
	ldr	r4, [sp, #44]
.L142:
	ldrd	r8, [sp, #48]
	cmp	r4, #0
	mov	r5, r8
	beq	.L162
	ldrd	r10, [sp]
	mov	r0, #0
	mov	r1, #0
	mov	r2, #1
	mov	r3, #0
.L152:
	and	lr, r0, #1
	and	ip, r5, r2
	eor	ip, ip, lr
	mul	lr, r2, r9
	umull	r6, r7, ip, r10
	mla	lr, r3, r8, lr
	umull	r2, r3, r2, r8
	mla	r7, ip, fp, r7
	strd	r2, [sp, #8]
	add	r3, lr, r3
	str	r3, [sp, #12]
	ldr	r3, [sp, #8]
	adds	r2, r3, r0
	ldr	r3, [sp, #12]
	adc	r3, r3, r1
	adds	r2, r6, r2
	adc	r3, r7, r3
	lsr	r0, r2, #1
	subs	r4, r4, #1
	mov	r2, #0
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	mov	r3, r2
	bne	.L152
	strd	r0, [sp, #8]
.L151:
	ldrd	r2, [sp]
	cmp	r3, r1
	cmpeq	r2, r0
	bls	.L139
	ldrd	r0, [sp, #8]
	add	sp, sp, #68
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L131:
	ldrd	r2, [sp, #8]
	orrs	r3, r2, r3
	movne	r10, r0
	movne	fp, r1
	movne	r4, #0
	strdne	r10, [sp, #48]
	bne	.L138
.L139:
	ldrd	r2, [sp]
	ldr	r1, [sp, #8]
	subs	r1, r1, r2
	str	r1, [sp, #8]
	ldr	r1, [sp, #12]
	sbc	r3, r1, r3
	str	r3, [sp, #12]
	ldrd	r0, [sp, #8]
	add	sp, sp, #68
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L185:
	ldr	r3, [sp, #44]
	cmp	r3, #0
	beq	.L144
	mov	r8, r3
	ldrd	r0, [sp, #48]
	mov	r2, #0
	mov	r3, #0
	mov	ip, r8
	str	r10, [sp, #24]
.L145:
	ldr	lr, [sp, #24]
	and	r8, r0, #1
	and	r4, r8, lr
	and	lr, r2, #1
	eor	lr, lr, r4
	umull	r4, r5, r8, r10
	ldrd	r6, [sp]
	strd	r4, [sp, #16]
	ldr	r9, [sp, #20]
	umull	r4, r5, lr, r6
	mla	r8, r8, fp, r9
	mla	r5, lr, r7, r5
	str	r8, [sp, #20]
	ldrd	r8, [sp, #16]
	adds	r6, r8, r2
	adc	lr, r9, r3
	adds	r6, r4, r6
	adc	lr, r5, lr
	lsr	r4, r0, #1
	orr	r4, r4, r1, lsl #31
	lsr	r2, r6, #1
	lsr	r5, r1, #1
	subs	ip, ip, #1
	orr	r2, r2, lr, lsl #31
	mov	r0, r4
	lsr	r3, lr, #1
	mov	r1, r5
	bne	.L145
	strd	r0, [sp, #48]
	ldrd	r0, [sp]
	ldr	ip, [sp, #24]
	cmp	r1, r3
	cmpeq	r0, r2
	strdhi	r2, [sp, #48]
	bhi	.L155
.L154:
	ldrd	r0, [sp]
	subs	lr, r2, r0
	sbc	r3, r3, r1
	str	r3, [sp, #52]
	ldr	r3, [sp, #44]
	str	lr, [sp, #48]
	cmp	r3, #0
	bne	.L155
.L161:
	mov	r2, #0
	mov	r3, #0
	b	.L147
.L183:
	ldr	ip, [sp, #48]
	subs	ip, ip, r0
	str	ip, [sp, #48]
	ldr	ip, [sp, #52]
	sbc	r1, ip, r1
	str	r1, [sp, #52]
	b	.L157
.L184:
	subs	r10, r10, r2
	sbc	fp, fp, r3
	b	.L141
.L144:
	ldrd	r2, [sp]
	orrs	r3, r2, r3
	movne	r2, #0
	movne	r3, #0
	strdne	r2, [sp, #48]
	bne	.L147
.L163:
	ldrd	r2, [sp]
	b	.L154
.L162:
	mov	r2, #0
	mov	r3, #0
	mov	r0, r2
	strd	r2, [sp, #8]
	mov	r1, r3
	b	.L151
.L158:
	mov	r3, #1
	str	r3, [sp, #24]
	mov	r2, r3
	mov	r3, #0
	b	.L133
.L159:
	mov	r2, #0
	mov	r3, #0
	strd	r2, [sp, #48]
	b	.L135
.L187:
	.align	2
.L186:
	.word	.LANCHOR0
	.size	decrypt, .-decrypt
	.align	2
	.global	profile
	.syntax unified
	.arm
	.fpu vfp
	.type	profile, %function
profile:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r0, #0
	sub	sp, sp, #24
	bl	srand
	ldr	r10, .L203
	mov	r9, #1000
.L194:
	bl	rand
	ldrd	r4, [r10, #8]
	ldrd	r2, [r10]
	orrs	r1, r4, r5
	mov	r6, r0
	asr	r7, r0, #31
	beq	.L189
	mov	r0, r4
	mov	r1, r5
	mov	lr, #0
.L190:
	lsr	ip, r0, #1
	orr	ip, ip, r1, lsl #31
	lsr	r8, r1, #1
	mov	r0, ip
	mov	r1, r8
	orrs	ip, r0, r1
	add	lr, lr, #1
	bne	.L190
	str	lr, [sp, #8]
	strd	r4, [sp]
	mov	r0, r6
	mov	r1, r7
	bl	modular_exponentiation
	ldrd	r2, [r10, #16]
	mov	lr, #0
	strd	r2, [sp, #16]
	mov	r2, r4
	mov	r3, r5
.L192:
	lsr	ip, r2, #1
	orr	ip, ip, r3, lsl #31
	lsr	r8, r3, #1
	mov	r2, ip
	mov	r3, r8
	orrs	ip, r2, r3
	add	lr, lr, #1
	bne	.L192
.L195:
	str	lr, [sp, #8]
	strd	r4, [sp]
	ldrd	r2, [sp, #16]
	bl	modular_exponentiation
	cmp	r7, r1
	cmpeq	r6, r0
	bne	.L202
	subs	r9, r9, #1
	bne	.L194
	add	sp, sp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L189:
	mov	r1, #0
	str	r1, [sp, #8]
	strd	r4, [sp]
	mov	r1, r7
	bl	modular_exponentiation
	ldrd	r2, [r10, #16]
	mov	lr, #0
	strd	r2, [sp, #16]
	b	.L195
.L202:
	ldr	r3, .L203+4
	mov	r2, #115
	ldr	r1, .L203+8
	ldr	r0, .L203+12
	bl	__assert_fail
.L204:
	.align	2
.L203:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	.LC0
	.word	.LC1
	.size	profile, .-profile
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	bl	profile
	mov	r0, #0
	pop	{r4, pc}
	.size	main, .-main
	.global	D_
	.global	E_
	.global	M_
	.section	.rodata
	.align	2
	.set	.LANCHOR1,. + 0
	.type	__PRETTY_FUNCTION__.6810, %object
	.size	__PRETTY_FUNCTION__.6810, 8
__PRETTY_FUNCTION__.6810:
	.ascii	"profile\000"
	.data
	.align	3
	.set	.LANCHOR0,. + 0
	.type	E_, %object
	.size	E_, 8
E_:
	.word	65537
	.word	0
	.type	M_, %object
	.size	M_, 8
M_:
	.word	-2063155181
	.word	8896677
	.type	D_, %object
	.size	D_, 8
D_:
	.word	1782482161
	.word	7169524
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"src/rsa-opt.c\000"
	.space	2
.LC1:
	.ascii	"msg == d\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
