module CLI where
    
import Options.Applicative
import Data.Semigroup ((<>))
import System.Console.ArgParser (boolFlag)

data Options = Options
  { sourceFile :: String
  , outputFile :: String
  , debugFlag  :: Bool
  } deriving Show

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
     <> value "output.bin" )
  <*> switch
      ( long "debug"
     <> help "debug flag")

optsParserInfo :: ParserInfo Options
optsParserInfo = info (optionsParser <**> helper)
  ( fullDesc
 <> header "MIPS 32 Assembler written in Haskell" )

