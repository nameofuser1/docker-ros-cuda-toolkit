import argparse
import os


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("-f", "--file", help="Path to rosdep files",
						required=True, type=str)

	args = parser.parse_args()

	data = "apt-get update" + os.linesep
	with open(args.file, "r") as f:
		for line in f:
			line = line.strip()
			if not line.startswith("#"):
				deps = line.split()[-1]
				data += "apt-get install -y " + deps + os.linesep

	with open(args.file, "w") as f:
		f.write(data)

	exit(0)