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

  program ::= [line]

  line ::= [label] instruction | directive | label

  instruction ::= RTypeInstruction | ITypeInstruction | JTypeInstruction

  RTypeInstruction ::= opcode rs rt rd shamt funct

  ITypeInstruction ::= opcode rs rt immediate

  JTypeInstruction ::= opcode address

  directive ::= directiveType [operand]



MIPS Instruction Set Resources:
https://student.cs.uwaterloo.ca/~isg/res/mips/opcodes 
https://www.d.umn.edu/~gshute/mips/directives-registers.pdf