module CLI where
    
import Options.Applicative
import Data.Semigroup ((<>))

-- Define the data type for command-line options
data Options = Options
  { sourceFile :: String
  , outputFile :: String
  } deriving Show

-- Define the parser for command-line options
optionsParser :: Parser Options
optionsParser = Options
  <$> argument str
      ( metavar "source-file"
     <> help "MIPS source file" )
  <*> strOption
      ( long "o"
     <> metavar "output-file"
     <> help "Name of output file"
     <> showDefault
     <> value "output.txt" )

-- Define the parser info with a description of your program
optsParserInfo :: ParserInfo Options
optsParserInfo = info (optionsParser <**> helper)
  ( fullDesc
 <> progDesc "MIPS 32 Assembler"
 <> header "MIPS 32 assembler written in Haskell" )
