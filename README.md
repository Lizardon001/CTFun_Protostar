How to build, run and connect to the protostar docker.
`sudo chmod u+x protostar.sh`
`./protostar.sh` - Show menu
`./protostart.sh build`
`./protostar.sh run`
 `./protostart.sh connect` 


# PROBLEM 
use this cmd with root permission(just use ./protostart.sh connect) bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space' to disable aslr this is temporary fix will soon be fix with addition of pwntools 
