MIPS Assembler

To-Do List:

1 - Write data structures for instructions (Instructions.hs)

2 - Write file handling stuff to import line by line and
    verify opcodes exist (Scanner.hs)

3 - Write a shitty parser to parse instructions (Parser.hs)

4 - Write functions for each opcode to translate them to their binary
    equivalent (Assembler.hs)
    
5 - Write resulting binary to file


NOTES:

-Handling jumping back to labels will be tricky in Haskell,
 look into that

-Figure out Haskell's argument parsing library



Shitty Grammar Idea: 

-- Program <- lines*

-- lines <-  directive  |  label? instruction 

-- instruction <- RType-Instruction | IType-Instruction | JType-Instruction

--  RType-Instruction <- opcode rs rd rt shamt funct

--  IType-Instruction <- opcode rs rt immediate

--  JType-Instruction <- opcode address

--Terminals: directive, label, opcode, rs, rd rt, shamt, funct, address


Resources:
https://student.cs.uwaterloo.ca/~isg/res/mips/opcodes 