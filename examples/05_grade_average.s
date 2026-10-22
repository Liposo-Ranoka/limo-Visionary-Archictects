# ==========================================================
# LIMO loop demo: average of student grades (array in memory)
# Uses: khh, lt, kop, hft/hlk loop control, ng-style shift note.
# ----------------------------------------------------------
# C-ish:  sum=0; for(i=0;i<5;i++) sum += grades[i];  avg = sum / 4 (shift)
# Here n=5, so we show the exact sum and integer sum>>2 only as a
# power-of-two demo; true average of 5 = sum / 5 needs a divide
# (LIMO has none), which is why the sum is stored as the result.
#
# Registers: x16 = ptr (Polokelo0), x17 reserved for ecall,
#            x18 = end ptr, x8 = sum (Nakoana0), x9 = element
# Expected: sum = 70+85+60+90+95 = 400 -> x8 = 400, x10 = 400 >> 2 = 100
# ==========================================================
        .data
grades: .word 70, 85, 60, 90, 95

        .text
        .globl main
main:
        la    x16, grades         # ptr  (la = lui+addi, assembler pseudo)
        addi  x18, x16, 20        # end = ptr + 5*4        (khh)
        addi  x8,  x0, 0          # sum = 0                (khh)

loop:
        beq   x16, x18, end       # hlk x16, x18, end      (ptr == end -> done)
        lw    x9, 0(x16)          # lt  r9, 0(r16)
        add   x8, x8, x9          # kop r8, r8, r9
        addi  x16, x16, 4         # khh r16, r16, 4
        beq   x0, x0, loop        # hlk r0, r0, loop       (unconditional)
end:
        addi  x11, x0, 2          # khh r11, r0, 2
        srl   x10, x8, x11        # right shift (see note in 03_average.s)

        addi  x17, x0, 10
        ecall
