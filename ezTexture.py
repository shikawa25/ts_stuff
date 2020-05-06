#!/usr/bin/env python3
import re 
import json
import sys
import argparse
import random
import string 

try:
    import pyperclip
except ImportError:
    import pip
    pip.main(['install', '--user', 'pyperclip'])
    import pyperclip

event_field = ["layer", "start", "end", "style", "name", "marginl", "marginr", "marginv", "effect", "text"]
confDict = ["fontsize", "loops", "blur", "colors", "cl1", "cl2", "cl3", "cl4", "cl5", "cl6"]
clipDict = ["x1", "y1", "x2", "y2"]

def parse_args(args):
    dsc = "Script to create fake textures"
    parser = argparse.ArgumentParser(description=dsc)
    parser.add_argument(type=str, dest="raw_line", metavar="Raw line")
    parser.add_argument(type=str, dest="config", metavar="Script configuration")
    return parser.parse_args(args)
    
args = parse_args(sys.argv[1:])    
raw_line = args.raw_line  
config = args.config

class Ass:
    def ass_parser(self):
        fieldsRegex = re.findall("(?:\:)(?:\s)(\d+)(?:\,)(\d+\:\d+\:\d+\.\d+)(?:\,)(\d+\:\d+\:\d+\.\d+)(?:\,)(\w+)(?:\,)(\w*)(?:\,)(\d+)(?:\,)(\d+)(?:\,)(\d+)(?:\,)(\w*)(?:\,)(.*)", raw_line)
        self.fieldsDict = dict(zip(event_field, fieldsRegex[0]))
        self.get_config()
        
    def get_config(self):
        configRegex = re.findall("(\d+)(?:\,)(\d+)(?:\,)(\d+)(?:\,)(\d+)(?:\,)(.{9})(?:\,)(.{9})(?:\,)(.{9})(?:\,)(.{9})(?:\,)(.{9})(?:\,)(.{9})", config)
        self.configDict = dict(zip(confDict, configRegex[0]))
        self.get_clip()
    
    def get_clip(self):
        clipRegex = re.findall("[-+]?\d*\.?\d+|\d+", self.fieldsDict["text"])
        self.coordinates = dict(zip(clipDict, clipRegex))
        self.fieldsDict.update(text='')
        self.loop_stuff()

    linesList = []        

    def create_lines(self):
        colorPool = []
        numberColors = range(int(self.configDict["colors"])) 
        for i in numberColors:
            colorPool.append(self.configDict["cl"+str(i+1)])
        minFontSize, maxFontSize = round(95*int(self.configDict["fontsize"])/100), round(105*int(self.configDict["fontsize"])/100)
        minX, maxX = round(float(self.coordinates["x1"])), round(float(self.coordinates["x2"]))
        minY, maxY = round(float(self.coordinates["y1"])), round(float(self.coordinates["y2"]))
        self.lineText = "{\\an5\\fnsplatter\\blur"+self.configDict["blur"]+"\c"+random.choice(colorPool)+"\\frz"+str(random.randint(1,360))+"\\fs"+str(random.randint(minFontSize,maxFontSize))+"\\pos("+str(random.randint(minX,maxX))+","+str(random.randint(minY,maxY))+")}"+random.choice(string.ascii_uppercase)
        baseText = "Dialogue: "+','.join(str(x) for x in self.fieldsDict.values())
        self.linesList.append(baseText+self.lineText)
        
    def loop_stuff(self):
        loopCount = 0
        while loopCount != int(self.configDict["loops"]):
            self.create_lines() 
            loopCount+=1
        output = '\n'.join(str(x) for x in self.linesList)
        pyperclip.copy(output)
        
foo = Ass()
foo.ass_parser()