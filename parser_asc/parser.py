__author__ = 'andersonpaac'
import argparse
import datetime

def parser():
    parser=argparse.ArgumentParser(description="")
    parser.add_argument("-i","--input",default="Unset")
    parser.add_argument("-o","--output",default="Unset")
    return parser

