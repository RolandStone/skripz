import os
import hashlib
import magic
import binwalk
import math

def extract_metadata(file_path):
    file_info = magic.Magic()
    print("File Type:", file_info.from_file(file_path))
    print("MIME Type:", magic.Magic(mime=True).from_file(file_path))
    print("File Size:", os.path.getsize(file_path), "bytes")

def strings_analysis(file_path):
    print("Extracting strings...")
    with open(file_path, 'rb') as file:
        data = file.read()
        strings = ''.join(chr(byte) if 32 <= byte < 127 else '\n' for byte in data).split('\n')
        for string in strings:
            if len(string) >= 4:  # Minimum length for meaningful strings
                print(string)

def hash_analysis(file_path):
    print("Calculating hashes...")
    with open(file_path, 'rb') as file:
        data = file.read()
        print("MD5:", hashlib.md5(data).hexdigest())
        print("SHA-1:", hashlib.sha1(data).hexdigest())
        print("SHA-256:", hashlib.sha256(data).hexdigest())

def binwalk_analysis(file_path):
    print("Performing binwalk analysis...")
    for module in binwalk.scan(file_path, signature=True, quiet=True):
        print("%s Results:" % module.name)
        for result in module.results:
            print("\t%s    0x%.8X" % (result.description, result.offset))

def entropy_analysis(file_path):
    print("Calculating entropy...")
    with open(file_path, 'rb') as file:
        byte_arr = list(file.read())
        file_size = len(byte_arr)
        if file_size == 0:
            return
        entropy = 0
        for i in range(256):
            xi = byte_arr.count(i)
            p_x = xi / file_size
            if p_x > 0:
                entropy += -p_x * math.log2(p_x)  # Fixed line
        print(f"Entropy: {entropy}")
        if 7 < entropy < 8:
            print("High entropy detected. Possible encryption or compression.")

def main_analysis(file_path):
    extract_metadata(file_path)
    strings_analysis(file_path)
    hash_analysis(file_path)
    binwalk_analysis(file_path)
    entropy_analysis(file_path)

def main():
    print("Welcome to Forensic Analysis Tool")
    file_path = input("Enter the path to the file or application: ")

    if not os.path.exists(file_path):
        print("File not found.")
        return

    print("\nAnalysis Options:")
    print("1. Full Analysis")
    print("2. Metadata Only")
    print("3. Strings Analysis")
    print("4. Hash Analysis")
    print("5. Binwalk Analysis")
    print("6. Entropy Analysis")
    print("7. Exit")
    
    while True:
        choice = input("Enter choice (1-7): ")
        if choice == '1':
            main_analysis(file_path)
        elif choice == '2':
            extract_metadata(file_path)
        elif choice == '3':
            strings_analysis(file_path)
        elif choice == '4':
            hash_analysis(file_path)
        elif choice == '5':
            binwalk_analysis(file_path)
        elif choice == '6':
            entropy_analysis(file_path)
        elif choice == '7':
            print("Exiting...")
            break
        else:
            print("Invalid choice.")

if __name__ == "__main__":
    main()
