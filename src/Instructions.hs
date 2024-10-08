-- module Instructions( Opcode(..), Instruction(..), Register(..)) where
module Instructions where 
import Data.Char (toUpper)
import Text.Read (readMaybe)

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

data Instruction = Instruction{opcode :: Opcode, operands :: [Operand]}  

data Operand = REGISTER 
             | IMMEDIATE 
             | ADDRESS 
             deriving(Show, Eq)

directives :: [String]
directives = ["data", "asciiz", "space", "word", "text"]

-- List of all implemented instructions and their operands
instructions :: [Instruction]
instructions = [
    Instruction{opcode = ADD, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = ADDU, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = ADDI, operands = [REGISTER, REGISTER, IMMEDIATE]},
    Instruction{opcode = ADDIU, operands = [REGISTER, REGISTER, IMMEDIATE]},
    Instruction{opcode = SUB, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = SUBU, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = DIV, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = DIVU, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = MULT, operands = [REGISTER, REGISTER]},
    Instruction{opcode = MULTU, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = AND, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = ANDI, operands = [REGISTER, REGISTER, IMMEDIATE]},
    Instruction{opcode = OR, operands = [REGISTER, REGISTER, REGISTER]},
    Instruction{opcode = ORI, operands = [REGISTER, REGISTER, IMMEDIATE]},
    Instruction{opcode = J, operands = [ADDRESS]},
    Instruction{opcode = JALR, operands = [ADDRESS]},
    Instruction{opcode = JR, operands = [REGISTER]}
  ]

-- enum for all opcodes (NOTE: Order here matters, don't change)
data Opcode = ADD  -- R Type Instructions
            | ADDU 
            | SUB  
            | SUBU 
            | MULT 
            | MULTU
            | DIV  
            | DIVU 
            | AND  
            | OR   
            | XOR  
            | NOR  
            | SLL  
            | SRL  
            | SRA  
            | MFHI 
            | MFLO 
            | MTHI 
            | MTLO  
            | ADDI  -- I Type Instructions
            | ADDIU
            | SLTI 
            | SLTIU
            | ANDI 
            | ORI  
            | XORI 
            | LW   
            | SW   
            | BEQ  
            | BNE  
            | BLTZ 
            | BGTZ 
            | BLEZ 
            | JALR  -- J Type Instructions
            | JUMP 
            | JAL  
            | J
            | JR
            deriving(Enum, Show, Read, Eq, Ord, Bounded)

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
                  --  SLLV -> "000100"
                    SRA -> "000011"
                   -- SRAV -> "000111"
                    SRL -> "000010"
                    SUB -> "100010"
                    SUBU -> "100011"
                    XOR -> "100110"
                    XORI -> "001110"
                  --  LB -> "100000"
                   -- LBU -> "100100"
                   -- LH -> "100001"
                   -- LI -> "999999" -- TEMP, REMOVE LATER
                   -- LHU -> "100101"
                    LW -> "100011"
                   -- SLT -> "101010"
                   -- SLTU -> "101001"
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
                    _ -> "ERROR: OPCODE NOT IMPLEMENTED"

registerToBinary :: Register -> String
registerToBinary op = case op of 
                    ZERO -> "100000"
                    AT -> "100001"
                    V0 -> "001000"
                    V1 -> "001001"
                    A0 -> "100100"
                    A1 -> "001100"
                    A2 -> "011010"
                    A3 -> "011011"
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
    

-- Converts string from scanner into opcode enum
toOpcode :: String -> Maybe Opcode
toOpcode op = readMaybe (map toUpper op) 
                 

-- Checks if opcode exists 
isOpcode :: String -> Bool
isOpcode op = case toOpcode op of
                 Just a -> True
                 Nothing -> False

-- Converts string from scanner into register enum
toRegister :: String -> Register
toRegister register = read $ map toUpper register


isDirective :: String -> Bool
isDirective str = str `elem` directives

-- Note: add custom error for when string to enum conversion fails
-- to find an existing register or opcode 

