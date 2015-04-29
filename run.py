
import parser_asc.parser as pars
import configlog.logger as lg
import logging

instruction_granularity = 50
def main():
    parser1 = pars.parser()
    lg.configLogger("resched")
    logging.info("Set logger---")
    getcontents(parser1.parse_args())


def getcontents(args):
    infile = args.input
    a = open(infile)
    dat = []
    g = a.readline()
    while '' != g:
        if g != "\n":
            if len(g) -1 > g.count(" "):
                dat.append(g)
        g = a.readline()

    a.close()
    divblocks(dat)

def divblocks(dat):
    bind = binding_blocks(dat)
    bind.consolidate()
    bind.display()
    #bind.writetofile("toread.asm")
    build_dep(bind)

def build_dep(bind):
    global instruction_granularity
    blocks = bind.blocks
    if len(blocks) == 0:
        logging.CRITICAL("NO BLOCKS FOUND")
        print "ENTER A VALID ASM"
        exit(-1)

    else:
        #Every block
        totalhazards = 0
        for alp in xrange(bind.countblocks()):
            care,insts = parseinst(bind.getblock(alp))
            logging.info("analyzing block "+str(alp))
            analyze = 0                                 #analyze is if blocks have a hazard.
            issues = []                                 #issues is an array of arrays. Each element in this array
                                                        #has two members start index , end index.
                                                        #the start index + 1 value represents the LW
                                                        #The end index represents until where to check
                                                        #@dev: lim not checked , handled outside.
                                                        #an array of arrays because there might be more than one hazard
                                                        #in the same block.
            #Runs several times per block.if a caremuch issue exists

            for each in care:
                #If next instruction is valid
                if len(insts) > each+1:
                    #If dependency exists
                    if insts[each].dest in insts[each+1].dep:
                        if insts[each+1].branchmuch ==0:
                            print alp , insts[each].rawtxt , insts[each+1].rawtxt
                            analyze = 1
                            issues.append([])
                            issues[len(issues)-1].append(each)
                            issues[len(issues)-1].append(each+instruction_granularity-1)
                            totalhazards = totalhazards + 1
                        else:
                            logging.CRITICAL("BUILDDEP:AVOIDED EDGE CASE - LD , JMP or LD , BR")
                else:
                    logging.info( "\tNo optimizations possible in block "+str(alp))

            #Runs once per block
            if analyze == 1:
                graphit(insts,issues)
        print "Total Possible Hazards"+str(totalhazards)

#graphit builds a dependency graph for the issues in hand. After resolving it calls fixit a helper function to replace
#the instructions.
#Edge case , multiple LW within instruction_granularity @todo
#Consider limits of issues (care-1)<0  , care+instruction_granularity > len(insts)
def graphit(insts,issues):
    logging.info("graphit:Entered , received params"+str(issues))
    for each in issues:
        #Care + instruction_granularity exceeds the length
        if each[1] >= len(insts):
            each[1] = len(insts)-1
            print "FIXED"
        print "graphit:"
        if (each[0]+2 > each[1]):
            logging.info ("TOO SMALL TO FIX")

        else:
            #Just for printing
            print insts[each[0]].rawtxt
            print insts[each[0]+1].rawtxt
            indice = each[0]+2
            dontstop = 1
            prevdests = [insts[each[0]+1].dest,insts[each[0]].dest]
            prevdep = insts[each[0]+1].dep

            while indice <= each[1] and dontstop == 1:
                #Just for printing
                print insts[indice].rawtxt
                if insts[indice].branchmuch == 1:
                    print "AVOIDED "+insts[indice].rawtxt
                    dontstop = 0
                    #logging.CRITICAL("GRAPHIT:AVOIDED EDGE CASE - LD , JMP or LD , BR")
                else:

                    ignore = 0
                    for depend in insts[indice].dep:
                        if depend in prevdep:
                            ignore =1
                    if insts[indice].dest in prevdests:
                        ignore = 1

                    if ignore == 1:
                        for depend in insts[indice].dep:
                            prevdests.append(depend)
                        prevdests.append(insts[indice].dest)
                    #Perfect candidate
                    else:
                        print "FOUND CANDIDATE "+insts[indice].rawtxt
                        dontstop = 0


                indice = indice + 1





#Given string of instructions can return insts array (array of instruction objects)
class DependencyNode:
    def __init__(self,block_num,inst_ind):
        self.block_num = block_num
        self.indices = [inst_ind]

    def addatblock(self,inst_ind):
        self.indices.append(inst_ind)


def parseinst(data):
    insts = []
    care = []
    #instruction(data[0])
    #
    i=0
    for each in data:
        inst = instruction(each)
        if inst.caremuch == 1:
            care.append(i)
        insts.append(inst)
        i = i + 1
    return care , insts




class instruction:
    #dep = []
    opcodes_rmem = ["LDR" ,"LDI" ,"LDB" ]
    opcodes = ["LDR" ,"LDI" ,"LDB" ,"STR" , "STI"  , "STB" , "ADD" , "AND" , "NOT" , "LSHF" ]
    opcodes.append("RSHFA")
    opcodes.append("LEA")
    opcodes.append("RSHFL")
    registers = ["R0","R1","R2","R3","R4","R5","R6","R7"]
    opcode_one = ["JMP" , "JSRR"]
    opcode_noop = ["TRAP" , "RET" , "JSR"] #instructions that have no dependencies or destinations
    def __init__(self,raw=None,opc=None,dest=None,sr1=None,sr2=None):
        self.dep =[]
        self.rawtxt = ""
        self.caremuch = 0
        if opc == None:
            self.rawtxt = raw
            raw = removeinitial(raw)
            #print raw
            if raw[0].upper() in self.opcodes:
                #print self.rawtxt
                self.branchmuch = 0
                self.opc = raw[0].upper()
                self.dest = self.registers.index(raw[1].upper())
                if len(raw) >= 4: # Dest and 2 source ex. ADD
                    self.dep.append(self.registers.index(raw[2].upper()))
                    if raw[3].upper() in self.registers:
                        if raw[3].upper() not in self.dep:
                            self.dep.append(self.registers.index(raw[3].upper()))
                        #print self.dep


                else:          # Dest and 1 sorurce ex. NOT
                    if raw[2].upper() in self.registers:
                        if raw[2].upper() not in self.dep:
                            self.dep.append(self.registers.index(raw[2].upper()))

            elif raw[0].upper() == "NOP":
                self.opc = raw[0]
                self.dep.append(80000)
                self.dest = 90000
                self.branchmuch = 0

            elif raw[0].upper()[0] == "B":
                self.opc = raw[0]
                self.dep.append(80000)
                self.dest = 90000
                self.branchmuch = 1

            elif raw[0].upper() in self.opcode_noop: #TRAP , RET , JSR
                self.opc = raw[0]
                self.branchmuch = 1

            elif raw[0].upper() in self.opcode_one: #JMP , JSRR
                self.opc = raw[0].upper()
                self.branchmuch = 1
                if raw[1].upper() in self.registers:
                    self.dep.append(self.registers.index(raw[1].upper()))


            else:
                print raw , "failed"
                logging.CRITICAL("instruction:init:FAILED at "+str(raw))
                exit(-1)
            if raw[0].upper() in self.opcodes_rmem:
                self.caremuch = 1
                #print "MUCH CARE SUCH WOW"

        #NOT BUILDING VIA RAW TEXT
        else:
            print "Class:Instruction:Building instructions through instruction builder"
            self.opcode = opc
            self.dest = dest
            self.dep.append(sr1)
            self.dep.append(sr2)

#Removes extra space at the start of instructions
def removeinitial(raw):
    #print "this",raw
    raw = raw.replace(",R",", R")
    gn = raw.split(" ")
    if gn[0] != "":
        return raw
    for i in xrange(len(gn)):
        if gn[i] != "":
            break
    retval = raw[i:-1].replace(",","").split(" ")

    while "" in retval:
        retval.remove("")
    return retval




class binding_blocks:
    block_distance = 4
    binds = []
    count_data2 = 0
    count_ignored =0
    count_newlines = 0
    min_block_size = 4
    blocks = {}
    def __init__(self,dat):
        self.initial = True
        self.data = dat
        self.clean()

    #Remove clean lines and get block data
    def clean(self):
        for i in xrange(len(self.data)):
            if i < len(self.data):
                #remove new lines
                if len(self.data[i]) == 1 and self.data[i] == "\n":
                    self.data.pop(i)
                    self.count_newlines = self.count_newlines + 1

            else:
                logging.info("binding_blocks: Cleaned " +str(self.count_newlines)+ " new lines")
                break

    def writetofile(self,fname=""):
        if fname != "":
            g = open(fname,"wb")
            g.write("".join(self.data))
            g.close()

    def addto(self,linenumber):
        self.binds.append(linenumber)

    def display(self):
        print self.binds
        print "Length of binds is "+ str(len(self.binds))
        print str(self.count_data2) + " Data segments ignored "
        print "BLOCKS\n"
        print self.blocks
        print "Length of blocks is "+ str(len(self.blocks))

    def consolidate(self):
        for i in xrange(len(self.data)):
            if ":" in self.data[i] and ("DATA2" not in self.data[i] or "DataSegment" not in self.data):
                    self.binds.append(i)

            #ignore datasegs
            if "DATA2" in self.data[i] and "FILL" not in self.data[i]:
                self.count_data2 = self.count_data2 + 1

        logging.info("building_blocke : consolidated")
        self.refine()

    def refine(self):
        i=1
        ins = 0
        while i<len(self.binds):
            if self.binds[i] - self.binds[i-1] >= self.min_block_size:  # is a block
                self.blocks[ins] = [self.binds[i-1],self.binds[i]]
                ins = ins + 1
            i = i + 1


    def getblock(self,block_num):
        logging.info("building_blocks:getblock:got  "+str(block_num)+" as block_num")
        if block_num > len(self.blocks):
            print "Invalid block"
            logging.CRITICAL("building_blocks:getblock:INVALID BLOCK")
            exit(-1)
            return None

        else:
            return self.data[self.blocks[block_num][0]+1:self.blocks[block_num][1]]

    def countblocks(self):
        return len(self.blocks)


#def parseinst(data):



main()
