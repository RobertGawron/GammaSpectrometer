import sys
import re

scad_generated_file_template = """
include <scad_input_filename>

scad_module();

"""

batch_file_name = "run_exports.sh"
scad_batch_script_command_template = \
    "openscad -o output_filename.stl  input_filename.scad\n"


def parseFile(scad_input_filename):
    scad_input_content = readFile(scad_input_filename)
    batch_file_content = ""

    # remove all whitespaces
    scad_input_content = re.sub(r'\s+', '', scad_input_content)

    # find module names
    scad_modules = re.findall(r'module(.*?)\(', scad_input_content)
    print("Modules found: {}". format(scad_modules))

    for scad_module in scad_modules:
        scad_generated_file_name = "{}.scad".format(scad_module)
        scad_generated_file_content = scad_generated_file_template \
            .replace("scad_input_filename", scad_input_filename) \
            .replace("scad_module", scad_module)

        writeToFile(scad_generated_file_name, scad_generated_file_content)

        batch_file_content += scad_batch_script_command_template \
            .replace("input_filename", scad_module) \
            .replace("output_filename", scad_module)

    writeToFile(batch_file_name, batch_file_content)

    print("\nScript to generate stl files was created {}"
          .format(batch_file_name))


def writeToFile(filename, filecontent):
    file = open(filename, 'w')
    file.write(filecontent)
    file.close()


def readFile(filename):
    file = open(filename, mode='r')
    file_content = file.read()
    file.close()

    return file_content


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Provide name of the .scad file to parse")
        print("Usage: {} [.scad filename]".format(sys.argv[0]))
    else:
        scad_input_filename = sys.argv[1]
        parseFile(scad_input_filename)
