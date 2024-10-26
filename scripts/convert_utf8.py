from pprint import pprint, pp
from pathlib import Path
# charset-normalizer can increase UnicodeDammit accuracy
import charset_normalizer
from bs4 import UnicodeDammit
from time import time
from concurrent import futures
import argparse


def convert_to_encoding(filepath, output_encoding, output_filename):
    with open(filepath, "rb") as f:
        rawdata = f.read()
    dammit = UnicodeDammit(rawdata, ['Big5', 'GB2312', 'EUC-TW', 'HZ-GB-2312', 'ISO-2022-CN', 'GBK', 'GB18030', 'UTF-8'])

    with open(output_filename, "w", encoding=output_encoding) as newfile:

        newfile.write(dammit.unicode_markup)

    return True


def convert_folder(directory):
    folder = Path(directory).absolute()
    output_folder = Path(folder / 'utf8')
    output_folder.mkdir(exist_ok=True)

    all_text_files = tuple(filename for filename in folder.rglob('*.txt') if not output_folder in filename.parents)

    def convert(filepath):
        output_filename = output_folder / filepath.relative_to(folder)
        output_filename.parent.mkdir(parents=True, exist_ok=True)
        if not convert_to_encoding(filepath, "utf8", output_filename):
            return filepath

    with futures.ThreadPoolExecutor(max_workers=8) as executor:
        failed = executor.map(convert, all_text_files)

    failed = [str(f.relative_to(folder)) for f in failed if f is not None]
    with open(output_folder / 'failed.txt', 'w') as failed_txt:
        pprint(failed, failed_txt)
    pp("failed:")
    pp(failed)

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--directory", help="root directory to convert all text files")
    args = parser.parse_args()

    starttime = time()
    convert_folder(args.directory)

    print(f"total time: {round(time() - starttime, 1)}")

if __name__ == "__main__":
    main()
