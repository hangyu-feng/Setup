import os
from pprint import pp
import sys
from pathlib import Path
import chardet


def convert_to_encoding(filepath, output_encoding, output_folder):
    with open(filepath, "rb") as f:
        rawdata = f.read()
    detect_result = chardet.detect(rawdata)
    old_encoding = detect_result["encoding"]

    try:
        text = rawdata.decode(encoding=old_encoding)
    except:
        try:
            text = rawdata.decode(encoding='mbcs')  # windows only ANSI codepage
        except UnicodeDecodeError:
            return False

    basename = filepath.name
    with open(output_folder / basename, "w", encoding=output_encoding) as newfile:
        # text = rawdata.decode(old_encoding, errors='ignore')
        newfile.write(text)

    return True


def main():

    folder = Path(r'C:\Users\VailG\h小说合集2密码cysj')
    output_folder = Path(folder / 'utf8')
    output_folder.mkdir(exist_ok=True)

    failed_list = []

    for file in os.scandir(folder):
        if file.name.endswith('.txt'):
            print(file.name)
            if not convert_to_encoding(file, "utf8", output_folder):
                failed_list.append(file.name)

    print("===========================")
    print("         failed")
    print("===========================")

    pp(failed_list)

if __name__ == "__main__":
    main()
