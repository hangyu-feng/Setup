from pprint import pprint, pp
from pathlib import Path
import chardet
from time import time
from joblib import Parallel, delayed
import argparse


def convert_to_encoding(filepath, output_encoding, output_filename):
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

    with open(output_filename, "w", encoding=output_encoding) as newfile:
        # text = rawdata.decode(old_encoding, errors='ignore')
        newfile.write(text)

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

    failed = Parallel(n_jobs=8)(
        delayed(convert)(filepath) for filepath in all_text_files
    )
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
