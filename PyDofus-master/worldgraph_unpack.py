import io, sys, os, json
from pydofus.worldGraph import WORLDGRAPH

# python d2p_pack.py (all files in input folder)
# folder output: ./output/{all files}.d2p

file = open("G:\Jeux\Dofus\content\maps\worldgraph.bin", "rb")

worldgraph = WORLDGRAPH(file)

print(worldgraph.read())
file.close()
