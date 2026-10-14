# ==========================================================
# LIMO Program 1: Addition (Kopanya)  ->  RV32I
# ----------------------------------------------------------
# LIMO:   kop r8, r6, r7        # r8 = r6 + r7
# RV32I:  add x8, x6, x7        # R-type, hex 0x00730433
#
# Register map (LIMO rN == RISC-V xN, same number):
#   r6 = x6 (Thuso0)    r7 = x7 (Thuso1)    r8 = x8 (Nakoana0)
# Run: RARS (Settings > Initialize PC to .text start) or Venus/Ripes
# Expected: x8 = 25 + 17 = 42
# ==========================================================
        .text
        .globl main
main:
        # --- harness: load inputs (LIMO: khh r6, r0, 25 / khh r7, r0, 17)
        addi  x6, x0, 25          # r6 = 25
        addi  x7, x0, 17          # r7 = 17

        # --- translated program
        add   x8, x6, x7          # kop r8, r6, r7

        # --- harness: exit (not part of LIMO ISA)
        addi  x17, x0, 10         # RARS ecall 10 = exit
        ecall
