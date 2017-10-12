import re

for n in range(1,2161):
    doc = "May 19-23 Room 65 Long Test/May 19-23 Room 65 Long Test_" + str(n)
    new_doc = "reduced/test_" + str(n)
    file = open(doc, "r")
    new_file = open(new_doc, "w")
    num_pattern = "-?\d+\.\d+E?-?\d+?"
    num_pattern2 = "-?\d+\.\d+E?-?\d+?"
    columns = re.findall("(" + num_pattern + ")\t" + num_pattern + "\t("+num_pattern2+")\t" + num_pattern + "\n",file.read())
    new_file.write("\n".join([" ".join(i) for i in columns]))
    file.close()
    new_file.close()
print(len(columns))