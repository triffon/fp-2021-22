module GroupX_fnY where


data Base = C | G | A | T
    deriving (Eq, Show)

data GeneticCode = GeneticCode [Base]
    deriving (Eq, Show)

data Codon = Codon Base Base Base
    deriving (Eq, Show)

data Aminoacid = Aminoacid Int
    deriving (Eq, Ord, Show)

type CodingTable = [(Codon, Aminoacid)]
type Gene = [Codon]
type Protein = [Aminoacid]

hasSameProteins :: CodingTable -> GeneticCode -> Bool
hasSameProteins = undefined

maxMutations :: CodingTable -> GeneticCode -> Int
maxMutations = undefined
