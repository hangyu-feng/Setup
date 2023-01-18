from pprint import pprint, pp
from pathlib import Path
import chardet
from time import time
from joblib import Parallel, delayed


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


def main():

    folder = Path(r'C:\Users\VailG\OneDrive\桌面\h小说合集1密码cysj').absolute()
    output_folder = Path(folder / 'utf8')
    output_folder.mkdir(exist_ok=True)

    all_text_files = tuple(filename for filename in folder.rglob('*.txt') if not output_folder in filename.parents)

    def convert(filepath):
        output_filename = output_folder / filepath.relative_to(folder)
        output_filename.parent.mkdir(exist_ok=True)
        if not convert_to_encoding(filepath, "utf8", output_filename):
            return filepath

    starttime = time()

    failed = Parallel(n_jobs=16)(
        delayed(convert)(filepath) for filepath in all_text_files
    )
    print(f"total time: {round(time() - starttime, 1)}")

    print("===========================")
    print("         failed")
    print("===========================")

    failed = [str(filename.relative_to(folder)) for filename in failed if filename is not None]
    with open(output_folder / 'failed.txt', 'w') as failed_txt:
        pprint(failed, failed_txt)
    pp(failed)

if __name__ == "__main__":
    main()
