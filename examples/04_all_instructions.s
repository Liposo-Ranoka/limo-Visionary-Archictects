# ==========================================================
# LIMO full-ISA demo: every one of the 10 instructions -> RV32I
# ----------------------------------------------------------
#  #  LIMO  RV32I        note
#  1  kop   add          R
#  2  ts    sub          R
#  3  khh   addi         I
#  4  le    and          R
#  5  kp    or           R
#  6  ng    sll          R-type shift left by register
#  7  lt    lw           I
#  8  blk   sw           S
#  9  hlk   beq          B
# 10  hft   (rs1>rs2) -> blt rs2, rs1, target   (RV32I has no BGT)
#
# Expected final: x15 = 1 (all checks passed), x8..x14 as noted
# ==========================================================
        .text
        .globl main
main:
        addi  x6, x0, 12          # khh r6, r0, 12
        addi  x7, x0, 5           # khh r7, r0, 5
        addi  x2, x2, -16         # khh r2, r2, -16

        add   x8,  x6, x7         # kop r8,  r6, r7   -> 17
        sub   x9,  x6, x7         # ts  r9,  r6, r7   -> 7
        and   x10, x6, x7         # le  r10, r6, r7   -> 4   (1100 & 0101)
        or    x11, x6, x7         # kp  r11, r6, r7   -> 13  (1100 | 0101)
        sll   x12, x7, x7         # ng  r12, r7, r7   -> 5 << 5 = 160

        sw    x8, 0(x2)           # blk r8, 0(r2)
        lw    x13, 0(x2)          # lt  r13, 0(r2)    -> 17

        # hlk: branch if equal  (x13 == x8 ? yes)
        beq   x13, x8, equal_ok   # hlk r13, r8, equal_ok
        addi  x15, x0, 0          # fail path
        beq   x0, x0, done        # hlk r0, r0, done  (unconditional)
equal_ok:
        # hft: branch if greater (x6 > x7 ? yes) => blt x7, x6
        blt   x7, x6, gt_ok       # hft r6, r7, gt_ok
        addi  x15, x0, 0
        beq   x0, x0, done
gt_ok:
        addi  x15, x0, 1          # all checks passed
done:
        addi  x2, x2, 16
        addi  x17, x0, 10
        ecall
