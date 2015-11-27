#!/usr/bin/python3
#-*- coding: utf-8 -*-

# Tests pour voir si on peut avoir un crible compressé, et sous quelle forme (bit/byte)
import zlib
import bz2
import lzma
import time


def sieveBit(nBytes):
    buf = bytearray(nBytes)
    for i in range(2,nBytes*8):
        if buf[i//8] & (1<<(i%8)):
            continue
        for j in range(2*i, nBytes*8, i):
            buf[j//8] |= (1<<(j%8))
    return buf


def sieveByte(nBytes):
    buf = bytearray(nBytes)
    for i in range(2,nBytes):
        if buf[i]:
            continue
        for j in range(2*i, nBytes, i):
            buf[j] = 1
    return buf


def stats(n=8*1048576*10):
    t0 = time.time()
    bufb = sieveBit(n//8)
    print('bufb done ({:.2f}s)'.format(time.time()-t0))
    t0 = time.time()
    bufB = sieveByte(n)
    print('bufB done ({:.2f}s)'.format(time.time()-t0))
    t0 = time.time()
    print('deflate: b {: 6} B {: 6} ({:.2f}s)'.format(len(zlib.compress(bufb,9)), len(zlib.compress(bufB,9)), time.time()-t0))
    t0 = time.time()
    print('bz2    : b {: 6} B {: 6} ({:.2f}s)'.format(len(bz2.compress(bufb,9)), len(bz2.compress(bufB,9)), time.time()-t0))
    t0 = time.time()
    print('lzma   : b {: 6} B {: 6} ({:.2f}s)'.format(len(lzma.compress(bufb)), len(zlib.compress(bufB)), time.time()-t0))

if __name__=='__main__':
    stats()
