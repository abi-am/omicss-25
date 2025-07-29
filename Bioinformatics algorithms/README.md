  # Contributors
    Primary contributor: Lusine Adunts
    Contributing authors: Tatev Jalatyan, Davit Hakobyan 
    
  Shared folder: [Google Drive](https://drive.google.com/drive/u/4/folders/1DK8PhIzSHEpXcoZzDfy6Ec2mNR4Zb07p)


  # Contents
  This module introduces core algorithms and techniques in bioinformatics. The topics are structured over five days of instruction, combining theory with practice:

  ### Day 1: Sequence Comparison  
  - Exact matching algorithms  
  - Sequence alignment: concepts and types  
  - Global alignment using the Needleman-Wunsch algorithm (Dynamic Programming)

  ### Day 2: Local and Semi-Global Alignment  
  - Local alignment using the Smith-Waterman algorithm  
  - Semi-global alignment with a focus on read alignment scenarios

  ### Day 3: Seeds and Indexing  
  - Introduction to seed-based matching  
  - Indexing techniques (e.g., suffix arrays, hash tables) used before alignment

  ### Day 4: Genome Assembly  
  - Concepts and challenges in genome assembly  
  - Overlap-layout-consensus and de Bruijn graph-based methods

  ### Day 5: Phylogenetic Trees  
  - Principles of phylogenetic tree construction  
  - UPGMA method for building evolutionary trees

  # TODO

  ### Lusine Adunts
  - [x] Day 1 slides
  - [x] Day 2 slides
  - [x] Day 3 slides
  - [x] Day 4 slides
  - [ ] Day 5 slides
  - [ ] Final touch

  ### Tatev Jalatyan
  - [x] Day 1 practice problems
    - Implement pattern matching using the naive approach
    - Implement pattern matching using the Boyer–Moore algorithm
    - Create conceptual questions to differentiate types of sequence alignment
    - Design a step-by-step global alignment task using Needleman–Wunsch, including:
      - Initialization
      - Matrix filling
      - Traceback
  - [x] Day 3 practice problems
     - Implement seed extraction from reads and genome (e.g., non-overlapping and overlapping k-mers)
     - Design a filtering rule that selects only seed hits that are near each other
     - Build a prefix tree (trie) from a list of k-mers
     - Query the trie for a prefix of length ≤ k
     - (Bonus) Put all together:
       - Extract k-mers from the read
       - Build an index (trie) from a genome fragment
       - Find seed hits by querying the index
       - Select nearby seed matches
       - Do full alignment on the selected region(s)
       - Choose the best alignment
  - [ ] Day 5 practice problems

  ### Davit Hakobyan
  - [x] Day 2 practice problems
    - Implement local alignment using the Smith-Waterman algorithm
    - Implement semi-global alignment for read alignment
    - Create questions to:
      - Compare global, local, and semi-global alignment algorithms including key differences in initialization, matrix filling, and traceback
      - Evaluate how different substitution matrices (e.g., PAM, BLOSUM) affect alignment scoring and interpretation
  - [ ] Day 4 practice problems
    - Assemble the genome through overlap graph
    - Assemble the genome through de Bruijn graph
    - Conceptual questions on assembly, the two main approaches, challenges
