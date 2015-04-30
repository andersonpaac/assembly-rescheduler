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