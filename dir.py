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


def finfo(ffn):
    sobj = os.stat(ffn)
    fn = os.path.basename(ffn)
    fobj = {
        "name": fn,
        "fname": ffn,
        "url": "https://www.example.com/"+ffn,
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


def walktree(top, callback):
    dstruct = { "dirs": [], "files": [] }
    for f in os.listdir(top):
        pathname = os.path.join(top, f)
        mode = os.stat(pathname).st_mode
        if S_ISDIR(mode):
            sub = walktree(pathname, callback)
            dstruct["dirs"].append(sub)
        elif S_ISREG(mode):
            res = callback(pathname)
            dstruct["files"].append(res)
    return dstruct

walk_dir = "."
if len(sys.argv) > 1:
    walk_dir = sys.argv[1]

walk_dir_abs = os.path.abspath(walk_dir)
print("-=[ "+walk_dir_abs, file=sys.stderr)

def flatDir(walk_dir):
    dstruct = {}
    for root, subdirs, files in os.walk(walk_dir):
        farr = []
        for fn in files:
            ffn = os.path.join(root, fn)
            fobj = finfo(ffn)
            farr.append(fobj)
        dstruct[root] = farr
    return dstruct

hiera = walktree(walk_dir, finfo)
flat = flatDir(walk_dir)


print("--=[ Hiera: YAML ]=--")
print(yaml.dump(hiera))
print("--=[ Hiera: JSON ]=--")
print(json.dumps(hiera, indent=2))

print("--=[ Flat: YAML ]=--")
print(yaml.dump(flat))
print("--=[ Flat: JSON ]=--")
print(json.dumps(flat, indent=2))
