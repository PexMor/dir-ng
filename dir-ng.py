#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
import os
import sys
import yaml
import json
from stat import *
from datetime import datetime, timezone
import hashlib
import argparse


def hashFile(hashName, filename):
    h = hashlib.new(hashName)
    b = bytearray(128*1024)
    mv = memoryview(b)
    with open(filename, 'rb', buffering=0) as f:
        for n in iter(lambda: f.readinto(mv), 0):
            h.update(mv[:n])
    return h.hexdigest()

def fixName2(ffn,removePfx,addPfx):
    tmp_path = ffn
    if len(removePfx) >0:
        cut = len(removePfx) + 1
        tmp_path = ffn[cut:]
    if len(tmp_path)>0:
        if len(addPfx)>0:
            tmp_path = addPfx + "/" + tmp_path
    else:
        tmp_path = addPfx
    
    return tmp_path

def finfo(ffn):
    global urlBase,root_pfx,url_pfx
    sobj = os.stat(ffn)
    fn = os.path.basename(ffn)
    fobj = {
        "name": fn,
        "fname": fixName2(ffn,config.walk_dir,config.rel_pfx),
        "url": config.url_base + "/" + fixName2(ffn,config.walk_dir,config.url_ifx),
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
            if fn != config.self_fn:
                ffn = os.path.join(root, fn)
                fobj = finfo(ffn)
                farr.append(fobj)
        # root_pfx
        if not config.no_empty or len(farr)>0:
            dstruct[fixName2(root,config.walk_dir,config.rel_pfx)] = farr
    return dstruct

def parse_args():
    parser = argparse.ArgumentParser(
        description='Walk the directory tree and produce metadata',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    parser.add_argument('walk_dir',
        type=str, nargs="?", default=".",
        help='directory to walk down')
    parser.add_argument('--url-base',
        type=str, default= "https://www.example.com/share",
        help='common url prefix for files')
    parser.add_argument('--rel-pfx',
        type=str, default='.', help='metadata file path prefix')
    parser.add_argument('--rel-ldn',
        type=bool, default=True, help='add last part of the walk_directory as file path prefix')
    parser.add_argument('--url-ifx',
        type=str, default='', help='file path infix used for URL')
    parser.add_argument('--self-fn',
        type=str, default='dir-ng.json', help='filename to omit from listings')
    parser.add_argument('--wrap-fn',
        type=str, help='a json file that wraps the file listing')
    parser.add_argument('--yaml',
        type=bool, default=False, help='Output yaml instead of json')
    parser.add_argument('--no-empty',
        type=bool, default=True, help='Skip empty folder')
    args = parser.parse_args()
    return args
    
def main():
    global config
    config = parse_args()
    if (config.rel_ldn):
        config.rel_pfx = config.walk_dir.split("/")[-1]

    # walk_dir_abs = os.path.abspath(config.walk_dir)

    flat = flatDir(config.walk_dir)
    wrap = {}
    if config.wrap_fn is not None:
        with open(config.wrap_fn) as f:
            wrap = json.load(f)        
    wrap["Files"] = flat

    print(json.dumps(wrap, indent=2))

if __name__ == "__main__":
    main()
