#This program is to be run with a given asm file
    
```
python run.py -i test.asm -o output.asm
```

Initial -
    Identify blocks
    Identify datasegs
    
Current :
    Strips "DATA2" strips "DATASEGMENT"
    Can detect hazards
   
@todo:
    Unhandled edges:    multiple in one
   
@IN_PROG:
   cp1.asm
   
@possible_problems:
    ending block recognition
    middle data block with  :FIXED