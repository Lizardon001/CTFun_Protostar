How to build, run and connect to the protostar docker.
`sudo chmod u+x protostar.sh`
`./protostar.sh` - Show menu
`./protostart.sh build`
`./protostar.sh run`
 `./protostart.sh connect` 


# PROBLEM 
use this cmd  bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space' with root permission (just use ./protostart.sh connect) to disable aslr this is temporary fix will soon be fix with addition of pwntools too
