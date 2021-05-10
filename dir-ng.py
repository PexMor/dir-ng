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

def fixName(ffn,pfx):
    cut = len(pfx) + 1
    return ffn[cut:]

def finfo(ffn):
    global urlBase,root_pfx,url_pfx
    sobj = os.stat(ffn)
    fn = os.path.basename(ffn)
    fobj = {
        "name": fn,
        "fname": fixName(ffn,root_pfx),
        "url": urlBase + "/" + fixName(ffn,url_pfx),
        "size": sobj.st_size,
        "mtime": sobj.st_mtime,
        "mtime_human": str(datetime.fromtimestamp(sobj.st_mtime, tz=timezone.utc)),
        "hashes": getHashes(ffn)
    }
    return fobj


def getHashes(fn):
    hash_list = {}
    hash_names = ["md5", "sha1", "sha256"]
    for hash_name in hash_names:
        hash_list[hash_name] = hashFile(hash_name, fn)
    return hash_list

def flatDir(walk_dir):
    dstruct = {}
    for root, subdirs, files in os.walk(walk_dir):
        farr = []
        for fn in files:
            if fn != "dir-ng.json":
                ffn = os.path.join(root, fn)
                fobj = finfo(ffn)
                farr.append(fobj)
        dstruct[fixName(root,root_pfx)] = farr
    return dstruct

urlBase="https://www.example.com/shared/data"
walk_dir = "."

if len(sys.argv) > 1:
    walk_dir = sys.argv[1]

root_pfx = walk_dir

if len(sys.argv) > 2:
    root_pfx = sys.argv[2]

url_pfx = root_pfx

if len(sys.argv) > 3:
    url_pfx = sys.argv[3]

walk_dir_abs = os.path.abspath(walk_dir)

flat = flatDir(walk_dir)

print(json.dumps(flat, indent=2))
