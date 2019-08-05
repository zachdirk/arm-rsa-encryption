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
	.file	"rsa.c"
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
	orrs	ip, r2, r3
	beq	.L10
	push	{r4, r5, r6, r7, r8, lr}
	mov	r4, #0
	mov	r6, r2
	mov	r7, r1
	mov	r5, r0
	mov	r3, r4
	mov	r2, #1
.L9:
	mul	r3, r5, r3
	umull	r0, r1, r5, r2
	mla	r2, r2, r7, r3
	add	r4, r4, #1
	add	r1, r2, r1
	ldrd	r2, [sp, #24]
	bl	__aeabi_uldivmod
	cmp	r4, r6
	bne	.L9
	mov	r0, r2
	mov	r1, r3
	pop	{r4, r5, r6, r7, r8, pc}
.L10:
	mov	r2, #1
	mov	r3, #0
	mov	r0, r2
	mov	r1, r3
	bx	lr
	.size	integer_power, .-integer_power
	.align	2
	.global	montgomery_modular_multiplication
	.syntax unified
	.arm
	.fpu vfp
	.type	montgomery_modular_multiplication, %function
montgomery_modular_multiplication:
	@ args = 12, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #12
	ldr	r9, [sp, #56]
	cmp	r9, #0
	beq	.L20
	mov	r10, r0
	mov	fp, r1
	mov	lr, #0
	mov	r0, #0
	mov	r1, #0
.L18:
	rsb	r5, lr, #32
	lsr	ip, r10, lr
	sub	r4, lr, #32
	orr	ip, ip, fp, lsl r5
	orr	ip, ip, fp, lsr r4
	and	ip, ip, #1
	and	r4, r2, ip
	umull	r6, r7, r2, ip
	and	r8, r0, #1
	eor	r8, r8, r4
	ldr	r4, [sp, #48]
	mla	ip, ip, r3, r7
	umull	r4, r5, r8, r4
	strd	r6, [sp]
	str	ip, [sp, #4]
	ldr	ip, [sp, #52]
	add	lr, lr, #1
	mla	r5, r8, ip, r5
	ldr	ip, [sp]
	adds	r6, ip, r0
	ldr	ip, [sp, #4]
	adc	ip, ip, r1
	adds	r6, r4, r6
	adc	ip, r5, ip
	lsr	r0, r6, #1
	cmp	lr, r9
	orr	r0, r0, ip, lsl #31
	lsr	r1, ip, #1
	bne	.L18
.L17:
	ldrd	r2, [sp, #48]
	cmp	r3, r1
	cmpeq	r2, r0
	bhi	.L16
	ldr	r3, [sp, #48]
	subs	r0, r0, r3
	ldr	r3, [sp, #52]
	sbc	r1, r1, r3
.L16:
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L20:
	mov	r0, #0
	mov	r1, #0
	b	.L17
	.size	montgomery_modular_multiplication, .-montgomery_modular_multiplication
	.align	2
	.global	modular_exponentiation
	.syntax unified
	.arm
	.fpu vfp
	.type	modular_exponentiation, %function
modular_exponentiation:
	@ args = 12, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #52
	mov	fp, r0
	ldr	r6, [sp, #96]
	mov	r10, r1
	strd	r2, [sp, #24]
	lsls	r5, r6, #1
	beq	.L43
	mov	r4, #0
	ldrd	r8, [sp, #88]
	mov	r2, #1
	mov	r3, r4
.L25:
	adds	r0, r2, r2
	adc	r1, r3, r3
	add	r4, r4, #1
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_uldivmod
	cmp	r4, r5
	bne	.L25
	cmp	r6, #0
	beq	.L26
.L61:
	str	fp, [sp, #40]
	str	r10, [sp, #44]
	ldrd	r10, [sp, #88]
	mov	r0, #0
	mov	r1, #0
	mov	r7, #0
	mov	r8, #1
	mov	r9, r2
	str	r3, [sp, #20]
.L27:
	lsr	ip, r8, r7
	and	ip, ip, #1
	and	r3, ip, r9
	and	lr, r0, #1
	eor	lr, lr, r3
	umull	r2, r3, ip, r9
	umull	r4, r5, lr, r10
	strd	r2, [sp]
	ldr	r3, [sp, #20]
	ldr	r2, [sp, #4]
	mla	r5, lr, fp, r5
	mla	r3, ip, r3, r2
	add	r7, r7, #1
	str	r3, [sp, #4]
	ldr	r3, [sp]
	adds	r2, r3, r0
	ldr	r3, [sp, #4]
	adc	r3, r3, r1
	adds	r2, r4, r2
	adc	r3, r5, r3
	lsr	r0, r2, #1
	cmp	r7, r6
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	bne	.L27
	ldrd	r4, [sp, #88]
	strd	r0, [sp, #32]
	ldr	fp, [sp, #40]
	cmp	r5, r1
	cmpeq	r4, r0
	ldr	r10, [sp, #44]
	mov	r2, r9
	ldr	r3, [sp, #20]
	bhi	.L29
.L28:
	ldr	r1, [sp, #32]
	ldr	r0, [sp, #88]
	subs	r1, r1, r0
	str	r1, [sp, #32]
	ldr	r0, [sp, #92]
	ldr	r1, [sp, #36]
	sbc	r1, r1, r0
	cmp	r6, #0
	str	r1, [sp, #36]
	beq	.L30
.L29:
	mov	lr, #0
	mov	r4, #0
	mov	r5, #0
	mov	ip, r2
	mov	r7, r3
.L31:
	rsb	r2, lr, #32
	lsr	r1, fp, lr
	sub	r3, lr, #32
	orr	r1, r1, r10, lsl r2
	orr	r1, r1, r10, lsr r3
	and	r1, r1, #1
	and	r3, r4, #1
	and	r0, r1, ip
	eor	r0, r0, r3
	umull	r2, r3, r1, ip
	add	lr, lr, #1
	strd	r2, [sp]
	ldr	r3, [sp, #88]
	umull	r8, r9, r0, r3
	ldr	r3, [sp, #4]
	mla	r3, r1, r7, r3
	str	r3, [sp, #4]
	ldr	r3, [sp, #92]
	mla	r9, r0, r3, r9
	ldrd	r0, [sp]
	adds	r2, r0, r4
	adc	r3, r1, r5
	adds	r2, r8, r2
	adc	r3, r9, r3
	lsr	r4, r2, #1
	cmp	lr, r6
	orr	r4, r4, r3, lsl #31
	lsr	r5, r3, #1
	bne	.L31
	ldrd	r2, [sp, #88]
	cmp	r3, r5
	cmpeq	r2, r4
	bhi	.L32
	ldr	r3, [sp, #88]
	subs	r4, r4, r3
	ldr	r3, [sp, #92]
	sbc	r5, r5, r3
	cmp	lr, #0
	beq	.L44
.L32:
	mov	ip, #0
	mov	fp, ip
	str	r6, [sp, #96]
.L38:
	ldr	r3, [sp, #24]
	ldr	r1, [sp, #28]
	rsb	r2, ip, #32
	lsr	r3, r3, ip
	orr	r3, r3, r1, lsl r2
	sub	r2, ip, #32
	str	fp, [sp, #12]
	orr	r3, r3, r1, lsr r2
	and	r3, r3, #1
	str	r3, [sp, #8]
	ldrd	r2, [sp, #8]
	orrs	r3, r2, r3
	bne	.L60
.L34:
	mov	r7, #0
	ldrd	r8, [sp, #88]
	mov	r2, #0
	mov	r3, #0
	mov	r10, r7
	str	ip, [sp]
.L36:
	rsb	lr, r10, #32
	lsr	r1, r4, r10
	sub	r0, r10, #32
	orr	r1, r1, r5, lsl lr
	orr	r1, r1, r5, lsr r0
	and	lr, r1, #1
	and	r0, lr, r4
	and	r1, r2, #1
	eor	ip, r1, r0
	umull	r6, r7, lr, r4
	umull	r0, r1, ip, r8
	mla	r7, lr, r5, r7
	mla	r1, ip, r9, r1
	adds	lr, r6, r2
	adc	r3, r7, r3
	adds	lr, r0, lr
	ldr	r0, [sp, #96]
	adc	r1, r1, r3
	add	r10, r10, #1
	lsr	r2, lr, #1
	cmp	r10, r0
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	bne	.L36
	ldrd	r0, [sp, #88]
	ldr	ip, [sp]
	cmp	r1, r3
	cmpeq	r0, r2
	movhi	r4, r2
	movhi	r5, r3
	bhi	.L37
	ldr	r1, [sp, #88]
	subs	r4, r2, r1
	ldr	r1, [sp, #92]
	sbc	r5, r3, r1
.L37:
	ldr	r3, [sp, #96]
	add	ip, ip, #1
	cmp	ip, r3
	bne	.L38
	mov	r7, #0
	mov	lr, r7
	ldrd	r10, [sp, #32]
	ldrd	r6, [sp, #88]
	mov	r0, #0
	mov	r1, #0
	mov	r8, #1
.L39:
	lsr	ip, r8, lr
	and	ip, ip, #1
	and	r2, r10, ip
	and	r3, r0, #1
	eor	r9, r3, r2
	umull	r4, r5, r10, ip
	umull	r2, r3, r9, r6
	mla	r5, ip, fp, r5
	mla	r3, r9, r7, r3
	adds	ip, r4, r0
	adc	r1, r5, r1
	adds	ip, r2, ip
	ldr	r2, [sp, #96]
	adc	r3, r3, r1
	add	lr, lr, #1
	lsr	r0, ip, #1
	cmp	lr, r2
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	bne	.L39
.L33:
	ldrd	r2, [sp, #88]
	cmp	r3, r1
	cmpeq	r2, r0
	bhi	.L23
.L40:
	ldr	r3, [sp, #88]
	subs	r0, r0, r3
	ldr	r3, [sp, #92]
	sbc	r1, r1, r3
.L23:
	add	sp, sp, #52
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L60:
	mov	r7, #0
	mov	r10, r7
	ldrd	r6, [sp, #32]
	mov	r2, #0
	mov	r3, #0
	str	ip, [sp]
.L35:
	rsb	r0, r10, #32
	lsr	lr, r6, r10
	sub	r1, r10, #32
	orr	lr, lr, r7, lsl r0
	orr	lr, lr, r7, lsr r1
	and	lr, lr, #1
	and	r1, lr, r4
	and	ip, r2, #1
	eor	ip, ip, r1
	umull	r8, r9, lr, r4
	ldr	r1, [sp, #88]
	mla	r9, lr, r5, r9
	umull	r0, r1, ip, r1
	ldr	lr, [sp, #92]
	add	r10, r10, #1
	mla	r1, ip, lr, r1
	adds	ip, r8, r2
	adc	r3, r9, r3
	adds	ip, r0, ip
	ldr	r0, [sp, #96]
	adc	r1, r1, r3
	lsr	r2, ip, #1
	cmp	r10, r0
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	bne	.L35
	ldrd	r0, [sp, #88]
	ldr	ip, [sp]
	cmp	r1, r3
	cmpeq	r0, r2
	strdhi	r2, [sp, #32]
	bhi	.L34
	ldr	r1, [sp, #88]
	subs	r1, r2, r1
	sbc	r3, r3, lr
	str	r1, [sp, #32]
	str	r3, [sp, #36]
	b	.L34
.L30:
	ldrd	r2, [sp, #88]
	orrs	r3, r2, r3
	ldrdeq	r0, [sp, #88]
	beq	.L40
.L48:
	mov	r0, #0
	mov	r1, #0
	b	.L23
.L43:
	cmp	r6, #0
	mov	r2, #1
	mov	r3, #0
	bne	.L61
.L26:
	ldrd	r0, [sp, #88]
	orrs	r1, r0, r1
	bne	.L48
	ldrd	r0, [sp, #88]
	strd	r0, [sp, #32]
	b	.L28
.L44:
	mov	r0, #0
	mov	r1, #0
	b	.L33
	.size	modular_exponentiation, .-modular_exponentiation
	.align	2
	.global	encrypt
	.syntax unified
	.arm
	.fpu vfp
	.type	encrypt, %function
encrypt:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L105
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #60
	ldrd	r4, [r3, #8]
	ldr	r2, [r3]
	ldr	r3, [r3, #4]
	strd	r4, [sp]
	str	r3, [sp, #36]
	orrs	r3, r4, r5
	str	r2, [sp, #32]
	beq	.L81
	mov	r6, #0
.L64:
	lsr	r3, r4, #1
	orr	r3, r3, r5, lsl #31
	lsr	r2, r5, #1
	mov	r4, r3
	mov	r5, r2
	orrs	r3, r4, r5
	add	r6, r6, #1
	bne	.L64
	lsls	r8, r6, #1
	mov	fp, r1
	str	r0, [sp, #48]
	beq	.L82
	mov	r7, #0
	ldrd	r10, [sp]
	mov	r2, #1
	mov	r3, r7
	mov	r9, r1
.L66:
	adds	r0, r2, r2
	adc	r1, r3, r3
	add	r7, r7, #1
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_uldivmod
	cmp	r7, r8
	bne	.L66
	mov	fp, r9
.L65:
	cmp	r6, #0
	beq	.L67
	strd	r4, [sp, #40]
	str	fp, [sp, #52]
	mov	r0, #0
	mov	r1, #0
	mov	r7, #0
	mov	r10, #1
	mov	r5, r3
	mov	fp, r2
.L68:
	lsr	ip, r10, r7
	and	ip, ip, #1
	and	r3, fp, ip
	and	lr, r0, #1
	eor	lr, lr, r3
	umull	r2, r3, fp, ip
	add	r7, r7, #1
	strd	r2, [sp, #8]
	ldrd	r2, [sp]
	ldr	r4, [sp, #12]
	umull	r8, r9, lr, r2
	mla	ip, ip, r5, r4
	mla	r9, lr, r3, r9
	ldr	r3, [sp, #8]
	str	ip, [sp, #12]
	adds	r2, r3, r0
	adc	r3, ip, r1
	adds	r2, r8, r2
	adc	r3, r9, r3
	lsr	r0, r2, #1
	cmp	r7, r6
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	bne	.L68
	strd	r0, [sp, #24]
	ldrd	r8, [sp, #24]
	ldrd	r0, [sp]
	mov	r2, fp
	mov	r3, r5
	cmp	r1, r9
	cmpeq	r0, r8
	ldrd	r4, [sp, #40]
	ldr	fp, [sp, #52]
	bls	.L103
.L80:
	ldr	r7, [sp, #48]
	mov	lr, #0
	mov	ip, fp
.L70:
	rsb	r8, lr, #32
	lsr	r1, r7, lr
	sub	r0, lr, #32
	orr	r1, r1, ip, lsl r8
	orr	r1, r1, ip, lsr r0
	and	r1, r1, #1
	and	r8, r4, #1
	and	r0, r2, r1
	eor	r0, r0, r8
	umull	r10, fp, r2, r1
	ldr	r8, [sp]
	mla	fp, r1, r3, fp
	umull	r8, r9, r0, r8
	ldr	r1, [sp, #4]
	add	lr, lr, #1
	mla	r9, r0, r1, r9
	adds	r0, r10, r4
	adc	r1, fp, r5
	adds	r0, r8, r0
	adc	r1, r9, r1
	lsr	r4, r0, #1
	cmp	r6, lr
	orr	r4, r4, r1, lsl #31
	lsr	r5, r1, #1
	bhi	.L70
	ldrd	r2, [sp]
	cmp	r3, r5
	cmpeq	r2, r4
	bls	.L63
.L71:
	mov	ip, #0
	mov	fp, ip
.L76:
	ldr	r3, [sp, #32]
	ldr	r1, [sp, #36]
	rsb	r2, ip, #32
	lsr	r3, r3, ip
	orr	r3, r3, r1, lsl r2
	sub	r2, ip, #32
	str	fp, [sp, #20]
	orr	r3, r3, r1, lsr r2
	and	r3, r3, #1
	str	r3, [sp, #16]
	ldrd	r2, [sp, #16]
	orrs	r3, r2, r3
	bne	.L104
.L72:
	mov	r8, ip
	mov	r2, #0
	mov	r3, #0
	mov	r10, #0
	mov	ip, r6
.L74:
	rsb	lr, r10, #32
	lsr	r1, r4, r10
	sub	r0, r10, #32
	orr	r1, r1, r5, lsl lr
	orr	r1, r1, r5, lsr r0
	and	lr, r1, #1
	and	r0, lr, r4
	and	r1, r2, #1
	eor	r9, r1, r0
	umull	r6, r7, lr, r4
	ldr	r1, [sp]
	mla	r7, lr, r5, r7
	umull	r0, r1, r9, r1
	ldr	lr, [sp, #4]
	add	r10, r10, #1
	mla	r1, r9, lr, r1
	adds	lr, r6, r2
	adc	r3, r7, r3
	adds	lr, r0, lr
	adc	r1, r1, r3
	lsr	r2, lr, #1
	cmp	r10, ip
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	bne	.L74
	ldrd	r0, [sp]
	mov	r6, ip
	mov	ip, r8
	cmp	r1, r3
	cmpeq	r0, r2
	movhi	r4, r2
	movhi	r5, r3
	bhi	.L75
	subs	r4, r2, r0
	sbc	r5, r3, r1
.L75:
	add	ip, ip, #1
	cmp	ip, r6
	bne	.L76
	mov	r7, #0
	str	r6, [sp, #16]
	mov	lr, r7
	ldrd	r10, [sp, #24]
	ldrd	r6, [sp]
	mov	r4, #0
	mov	r5, #0
	mov	r8, #1
.L77:
	lsr	ip, r8, lr
	and	ip, ip, #1
	and	r3, r4, #1
	and	r2, ip, r10
	eor	r9, r3, r2
	umull	r2, r3, ip, r10
	mov	r0, r2
	mov	r1, r3
	umull	r2, r3, r9, r6
	strd	r0, [sp, #8]
	mla	r1, ip, fp, r1
	mla	r3, r9, r7, r3
	str	r1, [sp, #12]
	ldr	r1, [sp, #8]
	add	lr, lr, #1
	adds	r0, r1, r4
	ldr	r1, [sp, #12]
	adc	r1, r1, r5
	adds	r0, r2, r0
	ldr	r2, [sp, #16]
	adc	r3, r3, r1
	lsr	r4, r0, #1
	cmp	lr, r2
	orr	r4, r4, r3, lsl #31
	lsr	r5, r3, #1
	bne	.L77
.L67:
	ldrd	r2, [sp]
	cmp	r3, r5
	cmpeq	r2, r4
	bhi	.L62
	subs	r4, r4, r2
	sbc	r5, r5, r3
.L62:
	mov	r0, r4
	mov	r1, r5
	add	sp, sp, #60
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L104:
	str	r6, [sp, #8]
	ldrd	r6, [sp, #24]
	mov	r2, #0
	mov	r3, #0
	mov	r10, #0
	str	ip, [sp, #48]
.L73:
	rsb	r0, r10, #32
	lsr	lr, r6, r10
	sub	r1, r10, #32
	orr	lr, lr, r7, lsl r0
	orr	lr, lr, r7, lsr r1
	and	lr, lr, #1
	and	r1, lr, r4
	and	ip, r2, #1
	eor	ip, ip, r1
	umull	r8, r9, lr, r4
	ldr	r1, [sp]
	mla	r9, lr, r5, r9
	umull	r0, r1, ip, r1
	ldr	lr, [sp, #4]
	add	r10, r10, #1
	mla	r1, ip, lr, r1
	adds	ip, r8, r2
	adc	r3, r9, r3
	adds	ip, r0, ip
	ldr	r0, [sp, #8]
	adc	r1, r1, r3
	lsr	r2, ip, #1
	cmp	r10, r0
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	bne	.L73
	mov	r6, r0
	ldrd	r0, [sp]
	ldr	ip, [sp, #48]
	cmp	r1, r3
	cmpeq	r0, r2
	strdhi	r2, [sp, #24]
	bhi	.L72
	subs	lr, r2, r0
	sbc	r3, r3, r1
	str	lr, [sp, #24]
	str	r3, [sp, #28]
	b	.L72
.L81:
	mov	r2, r4
	mov	r3, r5
	mov	r6, #0
	strd	r2, [sp, #24]
.L63:
	subs	r4, r4, r2
	sbc	r5, r5, r3
	cmp	r6, #0
	bne	.L71
	mov	r4, #0
	mov	r5, #0
	b	.L67
.L103:
	ldr	ip, [sp, #24]
	subs	ip, ip, r0
	str	ip, [sp, #24]
	ldr	ip, [sp, #28]
	sbc	r1, ip, r1
	str	r1, [sp, #28]
	b	.L80
.L82:
	mov	r2, #1
	mov	r3, #0
	b	.L65
.L106:
	.align	2
.L105:
	.word	.LANCHOR0
	.size	encrypt, .-encrypt
	.align	2
	.global	decrypt
	.syntax unified
	.arm
	.fpu vfp
	.type	decrypt, %function
decrypt:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L150
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	sub	sp, sp, #60
	ldrd	r4, [r3, #8]
	ldr	r2, [r3, #16]
	ldr	r3, [r3, #20]
	strd	r4, [sp]
	str	r3, [sp, #36]
	orrs	r3, r4, r5
	str	r2, [sp, #32]
	beq	.L126
	mov	r6, #0
.L109:
	lsr	r3, r4, #1
	orr	r3, r3, r5, lsl #31
	lsr	r2, r5, #1
	mov	r4, r3
	mov	r5, r2
	orrs	r3, r4, r5
	add	r6, r6, #1
	bne	.L109
	lsls	r8, r6, #1
	mov	fp, r1
	str	r0, [sp, #48]
	beq	.L127
	mov	r7, #0
	ldrd	r10, [sp]
	mov	r2, #1
	mov	r3, r7
	mov	r9, r1
.L111:
	adds	r0, r2, r2
	adc	r1, r3, r3
	add	r7, r7, #1
	mov	r2, r10
	mov	r3, fp
	bl	__aeabi_uldivmod
	cmp	r7, r8
	bne	.L111
	mov	fp, r9
.L110:
	cmp	r6, #0
	beq	.L112
	strd	r4, [sp, #40]
	str	fp, [sp, #52]
	mov	r0, #0
	mov	r1, #0
	mov	r7, #0
	mov	r10, #1
	mov	r5, r3
	mov	fp, r2
.L113:
	lsr	ip, r10, r7
	and	ip, ip, #1
	and	r3, fp, ip
	and	lr, r0, #1
	eor	lr, lr, r3
	umull	r2, r3, fp, ip
	add	r7, r7, #1
	strd	r2, [sp, #8]
	ldrd	r2, [sp]
	ldr	r4, [sp, #12]
	umull	r8, r9, lr, r2
	mla	ip, ip, r5, r4
	mla	r9, lr, r3, r9
	ldr	r3, [sp, #8]
	str	ip, [sp, #12]
	adds	r2, r3, r0
	adc	r3, ip, r1
	adds	r2, r8, r2
	adc	r3, r9, r3
	lsr	r0, r2, #1
	cmp	r7, r6
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	bne	.L113
	strd	r0, [sp, #24]
	ldrd	r8, [sp, #24]
	ldrd	r0, [sp]
	mov	r2, fp
	mov	r3, r5
	cmp	r1, r9
	cmpeq	r0, r8
	ldrd	r4, [sp, #40]
	ldr	fp, [sp, #52]
	bls	.L148
.L125:
	ldr	r7, [sp, #48]
	mov	lr, #0
	mov	ip, fp
.L115:
	rsb	r8, lr, #32
	lsr	r1, r7, lr
	sub	r0, lr, #32
	orr	r1, r1, ip, lsl r8
	orr	r1, r1, ip, lsr r0
	and	r1, r1, #1
	and	r8, r4, #1
	and	r0, r2, r1
	eor	r0, r0, r8
	umull	r10, fp, r2, r1
	ldr	r8, [sp]
	mla	fp, r1, r3, fp
	umull	r8, r9, r0, r8
	ldr	r1, [sp, #4]
	add	lr, lr, #1
	mla	r9, r0, r1, r9
	adds	r0, r10, r4
	adc	r1, fp, r5
	adds	r0, r8, r0
	adc	r1, r9, r1
	lsr	r4, r0, #1
	cmp	r6, lr
	orr	r4, r4, r1, lsl #31
	lsr	r5, r1, #1
	bhi	.L115
	ldrd	r2, [sp]
	cmp	r3, r5
	cmpeq	r2, r4
	bls	.L108
.L116:
	mov	ip, #0
	mov	fp, ip
.L121:
	ldr	r3, [sp, #32]
	ldr	r1, [sp, #36]
	rsb	r2, ip, #32
	lsr	r3, r3, ip
	orr	r3, r3, r1, lsl r2
	sub	r2, ip, #32
	str	fp, [sp, #20]
	orr	r3, r3, r1, lsr r2
	and	r3, r3, #1
	str	r3, [sp, #16]
	ldrd	r2, [sp, #16]
	orrs	r3, r2, r3
	bne	.L149
.L117:
	mov	r8, ip
	mov	r2, #0
	mov	r3, #0
	mov	r10, #0
	mov	ip, r6
.L119:
	rsb	lr, r10, #32
	lsr	r1, r4, r10
	sub	r0, r10, #32
	orr	r1, r1, r5, lsl lr
	orr	r1, r1, r5, lsr r0
	and	lr, r1, #1
	and	r0, lr, r4
	and	r1, r2, #1
	eor	r9, r1, r0
	umull	r6, r7, lr, r4
	ldr	r1, [sp]
	mla	r7, lr, r5, r7
	umull	r0, r1, r9, r1
	ldr	lr, [sp, #4]
	add	r10, r10, #1
	mla	r1, r9, lr, r1
	adds	lr, r6, r2
	adc	r3, r7, r3
	adds	lr, r0, lr
	adc	r1, r1, r3
	lsr	r2, lr, #1
	cmp	r10, ip
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	bne	.L119
	ldrd	r0, [sp]
	mov	r6, ip
	mov	ip, r8
	cmp	r1, r3
	cmpeq	r0, r2
	movhi	r4, r2
	movhi	r5, r3
	bhi	.L120
	subs	r4, r2, r0
	sbc	r5, r3, r1
.L120:
	add	ip, ip, #1
	cmp	ip, r6
	bne	.L121
	mov	r7, #0
	str	r6, [sp, #16]
	mov	lr, r7
	ldrd	r10, [sp, #24]
	ldrd	r6, [sp]
	mov	r4, #0
	mov	r5, #0
	mov	r8, #1
.L122:
	lsr	ip, r8, lr
	and	ip, ip, #1
	and	r3, r4, #1
	and	r2, ip, r10
	eor	r9, r3, r2
	umull	r2, r3, ip, r10
	mov	r0, r2
	mov	r1, r3
	umull	r2, r3, r9, r6
	strd	r0, [sp, #8]
	mla	r1, ip, fp, r1
	mla	r3, r9, r7, r3
	str	r1, [sp, #12]
	ldr	r1, [sp, #8]
	add	lr, lr, #1
	adds	r0, r1, r4
	ldr	r1, [sp, #12]
	adc	r1, r1, r5
	adds	r0, r2, r0
	ldr	r2, [sp, #16]
	adc	r3, r3, r1
	lsr	r4, r0, #1
	cmp	lr, r2
	orr	r4, r4, r3, lsl #31
	lsr	r5, r3, #1
	bne	.L122
.L112:
	ldrd	r2, [sp]
	cmp	r3, r5
	cmpeq	r2, r4
	bhi	.L107
	subs	r4, r4, r2
	sbc	r5, r5, r3
.L107:
	mov	r0, r4
	mov	r1, r5
	add	sp, sp, #60
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L149:
	str	r6, [sp, #8]
	ldrd	r6, [sp, #24]
	mov	r2, #0
	mov	r3, #0
	mov	r10, #0
	str	ip, [sp, #48]
.L118:
	rsb	r0, r10, #32
	lsr	lr, r6, r10
	sub	r1, r10, #32
	orr	lr, lr, r7, lsl r0
	orr	lr, lr, r7, lsr r1
	and	lr, lr, #1
	and	r1, lr, r4
	and	ip, r2, #1
	eor	ip, ip, r1
	umull	r8, r9, lr, r4
	ldr	r1, [sp]
	mla	r9, lr, r5, r9
	umull	r0, r1, ip, r1
	ldr	lr, [sp, #4]
	add	r10, r10, #1
	mla	r1, ip, lr, r1
	adds	ip, r8, r2
	adc	r3, r9, r3
	adds	ip, r0, ip
	ldr	r0, [sp, #8]
	adc	r1, r1, r3
	lsr	r2, ip, #1
	cmp	r10, r0
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	bne	.L118
	mov	r6, r0
	ldrd	r0, [sp]
	ldr	ip, [sp, #48]
	cmp	r1, r3
	cmpeq	r0, r2
	strdhi	r2, [sp, #24]
	bhi	.L117
	subs	lr, r2, r0
	sbc	r3, r3, r1
	str	lr, [sp, #24]
	str	r3, [sp, #28]
	b	.L117
.L126:
	mov	r2, r4
	mov	r3, r5
	mov	r6, #0
	strd	r2, [sp, #24]
.L108:
	subs	r4, r4, r2
	sbc	r5, r5, r3
	cmp	r6, #0
	bne	.L116
	mov	r4, #0
	mov	r5, #0
	b	.L112
.L148:
	ldr	ip, [sp, #24]
	subs	ip, ip, r0
	str	ip, [sp, #24]
	ldr	ip, [sp, #28]
	sbc	r1, ip, r1
	str	r1, [sp, #28]
	b	.L125
.L127:
	mov	r2, #1
	mov	r3, #0
	b	.L110
.L151:
	.align	2
.L150:
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
	ldr	r10, .L167
	mov	r9, #1000
.L158:
	bl	rand
	ldrd	r4, [r10, #8]
	ldrd	r2, [r10]
	orrs	r1, r4, r5
	mov	r6, r0
	asr	r7, r0, #31
	beq	.L153
	mov	r0, r4
	mov	r1, r5
	mov	lr, #0
.L154:
	lsr	ip, r0, #1
	orr	ip, ip, r1, lsl #31
	lsr	r8, r1, #1
	mov	r0, ip
	mov	r1, r8
	orrs	ip, r0, r1
	add	lr, lr, #1
	bne	.L154
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
.L156:
	lsr	ip, r2, #1
	orr	ip, ip, r3, lsl #31
	lsr	r8, r3, #1
	mov	r2, ip
	mov	r3, r8
	orrs	ip, r2, r3
	add	lr, lr, #1
	bne	.L156
.L159:
	str	lr, [sp, #8]
	strd	r4, [sp]
	ldrd	r2, [sp, #16]
	bl	modular_exponentiation
	cmp	r7, r1
	cmpeq	r6, r0
	bne	.L166
	subs	r9, r9, #1
	bne	.L158
	add	sp, sp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L153:
	mov	r1, #0
	str	r1, [sp, #8]
	strd	r4, [sp]
	mov	r1, r7
	bl	modular_exponentiation
	ldrd	r2, [r10, #16]
	mov	lr, #0
	strd	r2, [sp, #16]
	b	.L159
.L166:
	ldr	r3, .L167+4
	mov	r2, #112
	ldr	r1, .L167+8
	ldr	r0, .L167+12
	bl	__assert_fail
.L168:
	.align	2
.L167:
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
	.type	__PRETTY_FUNCTION__.6813, %object
	.size	__PRETTY_FUNCTION__.6813, 8
__PRETTY_FUNCTION__.6813:
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
	.ascii	"src/rsa.c\000"
	.space	2
.LC1:
	.ascii	"msg == d\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
