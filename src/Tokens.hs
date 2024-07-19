module Tokens where 

import Instructions

data Tokens = LabelTok String
            | DirectiveTok (Maybe String)
            | OpcodeTok Opcode
            | RegisterTok Register
            | ShamtTok String
            | FunctTok String
            | AddressTok String
            | ImmediateTok String