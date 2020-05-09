#!/usr/bin/env python
"""
Not for production, example code to show how to pretty print
DAE files in a folder

Usage: python <this_file> <absolute_path_of_model_folder>
"""

import glob,os,sys
from xml.dom import minidom

def xml_to_pretty_xml(input_file_name):
    print ("Fixing the formatting in file %s \n", input_file_name)
    doc = minidom.parse(input_file_name)
    xmlstr = doc.toprettyxml(encoding="utf-8")
    temp_file_name = input_file_name + "_temp"
    old_file_name = input_file_name + "_old"
    with open(temp_file_name, "w") as f:       
        f.write(xmlstr)
    os.rename(input_file_name, old_file_name)
    os.rename(temp_file_name, input_file_name)
    os.remove(old_file_name)

def prettify_all_dae_in_this_folder(input_folder_path):
    os.chdir(input_folder_path)
    result = [y for x in os.walk(input_folder_path) \
           for y in glob.glob(os.path.join(x[0], '*.DAE'))]
    print(result)
    for filename in result:
        if "visual" in filename:  
            try: 
                xml_to_pretty_xml(filename)
            except:
                print ("Could not fix %s.", filename)

if __name__=="__main__":
    path = sys.argv[1]
    print ("Main path is %s", path)
    prettify_all_dae_in_this_folder(path)