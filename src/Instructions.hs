-- module Instructions( Opcode(..), Instruction(..), Register(..)) where
module Instructions where 
import Data.Char (toUpper)

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
            | LI
            | LHU  
            | LW
            | BEQ   -- branch instructions
            | BGTZ
            | BLEZ
            -- | BLTZAL
            -- | BLTZ
            | BNE
            | J     -- jump instructions
            | JAL
            | JALR
            | JR
            deriving(Enum, Show, Read, Eq)

-- Registers Enum
data Register = ZERO   
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
              deriving (Enum, Show, Read, Eq)

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
                    LI -> "999999" -- TEMP, REMOVE LATER
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

registerToBinary :: Register -> String
registerToBinary op = case op of 
                    ZERO -> "100000"
                    AT -> "100001"
                    V0 -> "001000"
                    V1 -> "001001"
                    A0-> "100100"
                    A1  -> "001100"
                    A2 -> "011010"
                    A3  -> "011011"
                    T0 -> "011000"
                    T1 -> "011001" 
                    T2 -> "011001"
                    T3 -> "011001"
                    T4 -> "011001"
                    T5 -> "011001"
                    T6 -> "011001"
                    T7 -> "011001"
                    S0 -> "011001"
                    S1 -> "011001"
                    S2 -> "011001"
                    S3 -> "011001"
                    S4 -> "011001"
                    S5 -> "011001"
                    S6 -> "011001"
                    S7 -> "011001"
                    T8 -> "100111"
                    T9 -> "100101"
                    K0 -> "001101"
                    K1 -> "000000"
                    GP -> "000100"
                    SP -> "000011"
                    FP -> "000111"
                    RA -> "000010"
    

numberToBinary :: String -> String
numberToBinary num = undefined

labelToBinary :: String -> String
labelToBinary label = undefined

-- Converts string from scanner into opcode enum
toOpcode :: String -> Opcode
toOpcode op = read $ map toUpper op

-- Converts string from scanner into register enum
toRegister :: String -> Register
toRegister register = read $ map toUpper register

-- Note: add custom error for when string to enum conversion fails
-- to find an existing register or opcode 


