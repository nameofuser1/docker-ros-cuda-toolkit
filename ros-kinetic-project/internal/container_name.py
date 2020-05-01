import argparse
import subprocess
import sys


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("-n", "--name", help="Project name",
				   required=True, type=str)

	args = parser.parse_args()
	sys.stdout.flush()

	proc = subprocess.Popen(['docker', 'ps', '-a'], stdout=subprocess.PIPE, stdin=None)
	out, err = proc.communicate()
	proc.stdout.close()

	for line in out.decode("utf-8").split('\n'):
		line = line.strip()
		params = line.split()
		
		if len(params) < 2:
			continue

		image_name = params[1]
		container_name = params[-1]

		if image_name == "ros-kinetic-" + args.name:
			sys.stdout.write(container_name)
			exit(0)

	sys.stderr.write("Container ros-kinetic-" + args.name + " not found!\n")
	exit(-1)