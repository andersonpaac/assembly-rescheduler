
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
        #print [g]
        g = g.replace("\t","    ")
        #remove comments
        if ":" not in g:
            if "ORIGIN" not in g:
                if g[0]!=" ":
                    g = "    "+g
        if ";" in g:
            g = g[:g.index(";")]+"\n"
        if g != "\n" and len(g.lstrip())>0:
            if g.lstrip()[0] != ";":
                if len(g) -1 > g.count(" "):
                    dat.append(g)

        g = a.readline()

    a.close()
    divblocks(dat,args)

def divblocks(dat,args):
    bind = binding_blocks(dat)
    bind.consolidate()
    #bind.display()
    #bind.writetofile("toread.asm")
    build_dep(bind,args)

def build_dep(bind,args):
    global instruction_granularity
    blocks = bind.blocks
    #bind.writetofile(args)
    if len(blocks) == 0:
        logging.critical("build_dep:NO BLOCKS FOUND")
        print "ENTER A VALID ASM"
        exit(-1)

    else:
        #Every block
        totalhazards = 0
        for alp in xrange(bind.countblocks()):
            logging.info("build_dep:alp="+str(alp))
            care,insts = parseinst(bind.getblock(alp))
            for i in insts:
                logging.info("build_dep:Returned:"+i.rawtxt)

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
                lel = graphit(insts,issues)
                bind.overwriteblock(rawoverwrite(lel,alp,bind.getformatterstat()),alp)

        print "Total Possible Hazards "+str(totalhazards)
        logging.debug("Total Possible Hazards "+str(totalhazards))
    bind.writetofile(args)

#graphit builds a dependency graph for the issues in hand. After resolving it calls fixit a helper function to replace
#the instructions.
#Edge case , multiple LW within instruction_granularity @todo
#Consider limits of issues (care-1)<0  , care+instruction_granularity > len(insts)
def graphit(insts,issues):
    #print issues
    logging.info("graphit:Entered , received params"+str(issues))
    for each in issues:
        #Care + instruction_granularity exceeds the length
        if each[1] >= len(insts):
            each[1] = len(insts)-1
            logging.info("graphit:Corrected size")
        print "graphit:"
        if (each[0]+2 > each[1]):
            logging.info("graphit:TOO SMALL TO FIX")

        else:
            #Just for printing
            print insts[each[0]].rawtxt
            print insts[each[0]+1].rawtxt
            logging.info("graphit:"+insts[each[0]].rawtxt+"\n"+insts[each[0]+1].rawtxt)
            indice = each[0]+2
            dontstop = 1
            prevdests = [insts[each[0]+1].dest,insts[each[0]].dest]
            prevdep = insts[each[0]+1].dep

            while indice <= each[1] and dontstop == 1:
                #Just for printing
                print insts[indice].rawtxt
                logging.info("graphit: "+insts[indice].rawtxt)
                if insts[indice].branchmuch == 1:
                    logging.debug( "gtaphit:AVOIDED "+insts[indice].rawtxt)
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
                        logging.debug("graphit:FOUND CANDIDATE "+insts[indice].rawtxt)
                        print "FOUND CANDIDATE "+insts[indice].rawtxt
                        dontstop = 0
                        tempinst = insts[indice]
                        print "tempinst set to "+tempinst.rawtxt
                        insts.insert(each[0]+1,tempinst)
                        insts.pop(indice+1)
                indice = indice + 1

        return insts

#given a block of instruction object , block number. It'll ensure binding_blocks get the right data
def rawoverwrite(lel,alp,formatterhelp):
    logging.info("rawoverwrite: Entered")
    retv = []
    for each in lel:
        retv.append(formatterhelp*" "+each.rawtxt)

    return retv



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
                
                print [raw] , "failed"
                logging.critical("instruction:init:FAILED at "+str(raw))
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



#binds are an array of linenumbers where a block line starts. It is at sasdda: not the next line (where the instuction
#starts
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
        logging.info("binding_blocks:clean: Complete")

    def writetofile(self,args):
        if args.output == "Unset":
            fname = args.input[:-4]+"_resch.asm"
        else:
            fname = args.output
        if fname != "":
            g = open(fname,"wb")
            g.write("".join(self.data))
            g.close()
        logging.critical("binding_blocks:writetofile:WROTE FILE to "+fname)
        print "Written to "+fname

    def addto(self,linenumber):
        self.binds.append(linenumber)

    def display(self):
        print self.binds
        print "Length of binds is "+ str(len(self.binds))
        print str(self.count_data2) + " Data segments ignored "
        print "BLOCKS\n"
        print self.blocks
        print "Length of blocks is "+ str(len(self.blocks))
    '''
    def consolidate(self):
        logging.info("binding_blocks:consolidate:Entered")
        for i in xrange(len(self.data)):
            if ":" in self.data[i] and ("DATA2" not in self.data[i] or "DataSegment" not in self.data):
                    print self.data[i]
                    self.binds.append(i)

            #ignore datasegs
            if "DATA2" in self.data[i] and "FILL" not in self.data[i]:
                self.count_data2 = self.count_data2 + 1
                logging.debug("building_blocks:consolidate: EDGE CASE IGNORED FILL")

        logging.info("building_blocks : consolidated")
        print "binds are",self.binds
        self.refine()

    def refine(self):
        i=1
        ins = 0
        print len(self.binds)
        while i<len(self.binds):
            if self.binds[i] - self.binds[i-1] >= self.min_block_size:  # is a block
                self.blocks[ins] = [self.binds[i-1],self.binds[i]]
                ins = ins + 1
            i = i + 1
        print "blocks are",self.blocks

    '''
    def consolidate(self):
        logging.info("binding_blocks:consolidate:Entered")
        self.blocks = {}
        ins = 0
        init1 = True
        for i in xrange(len(self.data)):
            if ":" in self.data[i] and ("data2" not in self.data[i].lower() and "datasegment" not in self.data[i].lower()):
                if self.data[i][0:3].lower() != "dat":
                    if self.data[i][0:3].lower() != "seg":
                        #print self.data[i]
                        self.binds.append(i)
                        if ins in self.blocks:
                            if self.blocks[ins][0] == i-1:
                                self.blocks[ins][0] = i
                                #print self.data[i] , self.blocks
                            else:
                                self.blocks[ins][1] = i
                                #print self.data[i],self.blocks
                                ins = ins + 1

                        if ins not in self.blocks:
                            self.blocks[ins] = [i,-999]

            if "data2 " in self.data[i].lower() or "datasegment" in self.data[i].lower() and ":" in self.data[i].lower():
                #print self.data[i].lower(),"entered"
                if ins in self.blocks:
                    self.blocks[ins][1] = i - 1
                    ins = ins + 1
                     #if it's not updated , update it

            if "dat"==self.data[i][0:3].lower() or "seg"==self.data[i][0:3].lower():
                if ins in self.blocks:
                    self.blocks[ins][1] = i - 1
                    ins = ins + 1

        if ins in self.blocks:
            if self.blocks[ins][1]==-999:
                self.blocks[ins][1] = len(self.data)-1
        logging.info("building_blocks : consolidated")
        print "binds are",self.binds
        print "new blocks are",self.blocks
        #self.refine()




    def getblock(self,block_num):
        logging.info("building_blocks:getblock:got  "+str(block_num)+" as block_num")
        if block_num > len(self.blocks):
            print "Invalid block"
            logging.critical("building_blocks:getblock:INVALID BLOCK")
            exit(-1)
            return None

        else:
            logging.info("binding_blocks:getblock: Returned data request for "+str(block_num))
            #print self.data[self.blocks[block_num][0]+1:self.blocks[block_num][1]]
            return  self.data[self.blocks[block_num][0]+1:self.blocks[block_num][1]]

    def countblocks(self):
        return len(self.blocks)

    def overwriteblock(self,inblock,block_num):
        self.data[self.blocks[block_num][0]+1 : self.blocks[block_num][1]] = inblock

    def getformatterstat(self):
        return len(self.data[self.blocks[0][0]+1])-len(self.data[self.blocks[0][0]+1].lstrip())


#def parseinst(data):



main()
