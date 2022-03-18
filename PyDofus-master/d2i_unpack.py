import sys, json, os
from pydofus.d2i import D2I, InvalidD2IFile

# python d2i_unpack.py file.d2i
# file output: file.json

path_input = "./input/"
path_output = "./output/"

for file in os.listdir(path_input):
    if file.endswith(".d2i"):
        file_name = os.path.basename(file)
        d2i_input = open(path_input + file, "rb")
        json_output = open(file.replace("d2i", "json"), "w", encoding="utf-8")

        d2i = D2I(d2i_input)
        data = d2i.read()

        json.dump(data, json_output, indent=2, ensure_ascii=False)

        d2i_input.close()
        json_output.close()
