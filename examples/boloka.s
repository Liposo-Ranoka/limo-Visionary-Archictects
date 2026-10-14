# ==========================================================
# LIMO Program 2: Store a constant (Boloka palo)  ->  RV32I
# ----------------------------------------------------------
# LIMO:   khh r8, r6, 15        # r8 = r6 + 15
#         blk r8, 4(r2)         # Mem[r2+4] = r8
# RV32I:  addi x8, x6, 15       # I-type, hex 0x00F30413
#         sw   x8, 4(x2)        # S-type
#
# r2 = x2 (Tshupo / sp), r6 = x6 (Thuso0), r8 = x8 (Nakoana0)
# Expected: x8 = 100 + 15 = 115; word at (sp+4) = 115; x9 = 115 (read back)
# ==========================================================
        .text
        .globl main
main:
        # --- harness
        addi  x6, x0, 100         # r6 = base value
        addi  x2, x2, -16         # reserve stack space (khh r2, r2, -16)

        # --- translated program
        addi  x8, x6, 15          # khh r8, r6, 15
        sw    x8, 4(x2)           # blk r8, 4(r2)

        # --- verify with a load (LIMO: lt r9, 4(r2))
        lw    x9, 4(x2)           # lt  r9, 4(r2)

        addi  x2, x2, 16          # release stack space

        addi  x17, x0, 10
        ecall
