module Instructions( Opcode(..), Instruction(..)) where

--    Terms used in MIPS    --
------------------------------
-- Instruction Types
    -- RType = Register Type
    -- IType = Intermediate Type
    -- JType = Jump Type
    
-- rs (source register)
-- rt (operand register)
-- rd (destination register)

-- shamt (shift amount)
-- funct (function)
-- immediate ()
------------------------------

-- data type for an opcode and its operands
data Instruction = RType { op :: Opcode, rs :: Int, rt :: Int, rd :: Int, shamt :: Int, funct :: Int }
                 | IType { op :: Opcode, rs :: Int, rt :: Int, immediate :: Int }
                 | JType { op :: Opcode, address :: Int }
                 deriving(Show)

-- enum for all opcodes
data Opcode = ADD   -- arithmetic instructions
            | ADDI 
            | ADDIU 
            | ADDU
            | DIV
            | DIVU
            | MULT
            | MULTU
            | SUB
            | SUBU
            | NOR  -- logical instructions
            | OR
            | ORI
            | AND
            | ANDI
            | XOR
            | XORI
            | SLL  -- shift instructions
            | SLLV
            | SRA
            | SRAV
            | SRL
            | SLT
            | SLTU
            | SLTI
            | SLTIU
            | LB  -- load instructions
            | LBU 
            | LH
            | LHU  
            | LW
            | BEQ   -- branch instructions
            | BGTZ
            | BLEZ
            | BLTZAL
            | BLTZ
            | BNE
            | J     -- jump instructions
            | JAL
            | JALR
            | JR
            deriving(Enum, Show)

-- Registers Enum
data Register
    = ZERO   
    | AT
    | V0     
    | V1     
    | A0     
    | A1     
    | A2     
    | A3     
    | T0     
    | T1     
    | T2     
    | T3     
    | T4     
    | T5     
    | T6     
    | T7     
    | S0     
    | S1     
    | S2     
    | S3     
    | S4     
    | S5     
    | S6     
    | S7     
    | T8     
    | T9     
    | K0     
    | K1     
    | GP     
    | SP     
    | FP     
    | RA     
    deriving (Enum, Bounded, Show, Eq)

-- type Register = String

opcodeToBinary :: Opcode -> String
opcodeToBinary op = case op of 
                    ADD  -> "100000"
                    ADDU -> "100001"
                    ADDI -> "001000"
                    ADDIU -> "001001"
                    AND -> "100100"
                    ANDI -> "001100"
                    DIV -> "011010"
                    DIVU -> "011011"
                    MULT -> "011000"
                    MULTU -> "011001"
                    NOR -> "100111"
                    OR -> "100101"
                    ORI -> "001101"
                    SLL -> "000000"
                    SLLV -> "000100"
                    SRA -> "000011"
                    SRAV -> "000111"
                    SRL -> "000010"
                    SUB -> "100010"
                    SUBU -> "100011"
                    XOR -> "100110"
                    XORI -> "001110"
                    LB -> "100000"
                    LBU -> "100100"
                    LH -> "100001"
                    LHU -> "100101"
                    LW -> "100011"
                    SLT -> "101010"
                    SLTU -> "101001"
                    SLTI -> "001010"
                    SLTIU -> "001001"
                    BEQ -> "000100"
                    BGTZ -> "000111"
                    BLEZ -> "000110"
                    BNE -> "000101"
                    J -> "000010"
                    JAL -> "000011"
                    JALR -> "001001"
                    JR -> "001000"


-- generateInstructionBinary :: Instruction -> String
-- generateInstructionBinary instr = case instr of 
--                                     RType {} -> opcodeToBinary instr.op ++ instr.rs ++ instr.rt ++ instr.rd + instr.shamt ++ instr.funct
--                                     IType {} -> opcodeToBinary instr.op ++ instr.rs ++ instr.rt ++ instr.immediate
--                                     JType {} -> opcodeToBinary instr.op ++ instr.address

-- writeInstructionBinary :: Instruction -> String
-- writeInstructionBinary instruction = case instruction of
--                                         RType -> writeRTypeBinary instruction
--                                         JType -> writeJTypeBinary instruction
--                                         IType -> writeITypeBinary instruction