.data
tabla1: .word 15,11,24
tabla2: .word 0,0,0

.code
DADDI R1, R0, 0
DADDI R2, R0, 3
LOOP: LD R3, tabla1(R1)
  DADDI R3, R3, 1
  SD R3, tabla2(R1)
  DADDI R2, R2, -1
  BNEZ R2, LOOP
  DADDI R1, R1, 8
  HALT

# IF - ID - EX - MEM - WB
#   - IF - ID - EX  - MEM - WB
#        - IF - ID - EX  - MEM - WB
#             - IF - RAW - ID - EX  - MEM - WB
#                  - IF  - [] - RAW - ID  - EX - MEM - WB
#                        - IF - []  - []  - ID - EX  - MEM - WB
#                             - IF  - []  - [] - ID  - EX  - MEM - WB
#                                   - IF  - [] - []  - RAW - ID - EX - MEM - WB
#                                         - IF - ID - EX  - MEM - []
