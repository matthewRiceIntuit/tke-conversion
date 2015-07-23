import os
import re
root = {}
parent={}

with open('CalcListener.py') as f:
    for each in  f.readlines():
        each = re.sub(r' def enter(\w+)(\(self, ctx\):)', r' def enter\1\2\n        self.enter("\1")', each)
        each = re.sub(r' def exit(\w+)(\(self, ctx\):)', r' def exit\1\2\n        self.exit()', each)

        each = re.sub(r' pass\n', r'', each)

        print each,

'''
def enterProgram(self, ctx):
        pass
'''