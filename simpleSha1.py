#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
import os
import sys
import yaml
import json
from stat import *
from datetime import datetime, timezone
import hashlib


def hashFile(hashName, filename):
    h = hashlib.new(hashName)
    b = bytearray(128*1024)
    mv = memoryview(b)
    with open(filename, 'rb', buffering=0) as f:
        for n in iter(lambda: f.readinto(mv), 0):
            h.update(mv[:n])
    return h.hexdigest()

if len(sys.argv)>1:
    with open(sys.argv[1]) as f:
        lines = f.read().splitlines()
    for line in lines:
        print(line+":"+hashFile("SHA1",line))
