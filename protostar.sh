#!/bin/bash
if [ $# -gt 0 ]; then
    if [[ "$1" == "build" ]]; then
    	echo -e "Building protostar..."
    	sudo docker build -t ctfun/protostar:1.0 .
		echo -e "Done."
	elif [[ "$1" == "stop" ]]; then
		echo -e "Stop protostar..."
    	sudo docker stop protostar
		echo -e "Done."
	elif [[ "$1" == "start" ]]; then
		echo -e "Starting protostar..."
	    if sudo docker start protostar; then
	    	echo -e "Done."
	    	echo -e "SSH server:port: $(sudo docker port protostar 22)"
	    else
	    	echo -e "protostar container doesn't exists, please run it!"
	    fi
	elif [[ "$1" == "run" ]]; then
		echo -e "Running protostar..."
		if sudo docker run --privileged -d -P --name protostar ctfun/protostar:1.0; then
			echo -e SSH server:port: $(sudo docker port protostar 22)
			echo -e "Done."
		else
			echo -e "protostar container already exists, please just start it!"
		fi
	elif [[ "$1" == "connect" ]]; then
		echo -e "Connecting to protostar..."
		if sudo docker exec -it protostar bash; then
			echo -e "Bye."
		else
			echo -e "protostar container doesn't exists, please start/run it!"
		fi
	elif [[ "$1" == "remove" ]]; then
		echo -e "Removing to protostar..."
		if sudo docker stop protostar && sudo docker rm protostar; then
			echo -e "Removed."
		else
			echo -e "protostar container doesn't exists, no need to remove it!"
		fi
	fi
else
	echo -e "Usage: ./protostar.sh [OPTION]"
	echo -e "options:"
	echo -e "	build: to build the image"
	echo -e "	run: to run the container for the first time"
	echo -e "	stop: to stop the container"
	echo -e "	start: to start an existing container"
	echo -e "	connect: to connect and get in the protostar container"
	echo -e "	remove: to remove the protostar container"
fi