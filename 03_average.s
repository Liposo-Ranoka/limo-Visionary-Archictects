# ==========================================================
# LIMO Program 3: Midpoint / simple average  ->  RV32I
# ----------------------------------------------------------
# LIMO:   kop r8, r6, r7        # r8 = a + b
#         khh r9, r0, 1         # r9 = 1
#         ng  r8, r8, r9        # r8 = r8 >> 1   (as written in the notes)
#
# NOTE: LIMO's 'ng' is specified as SLL (shift LEFT) but this program
# needs a shift RIGHT. RV32I has no 'ng' that shifts right, so the
# correct translation is SRL (logical right shift). Fix in the ISA:
# add a right-shift mnemonic (SRL, funct3=101, funct7=0000000).
#
# Expected: a=40, b=20 -> x8 = 30
# ==========================================================
        .text
        .globl main
main:
        # --- harness
        addi  x6, x0, 40          # r6 = a
        addi  x7, x0, 20          # r7 = b

        # --- translated program
        add   x8, x6, x7          # kop r8, r6, r7
        addi  x9, x0, 1           # khh r9, r0, 1
        srl   x8, x8, x9          # 'ng' used as >>  -> SRL

        addi  x17, x0, 10
        ecall
