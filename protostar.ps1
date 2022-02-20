
$container = 'protostar'
function PrintHelp() {
    
    Write-Output  "Usage: ./$($args[0]) [OPTION]"
    Write-Output  "options:"
    Write-Output  "	build: to build the image"
    Write-Output  "	run: to run the container for the first time"
    Write-Output  "	stop: to stop the container"
    Write-Output  "	start: to start an existing container"
    Write-Output  "	connect: to connect and get in the $container container"
    Write-Output  "	remove: to remove the $container container"
}

function IsContainerExists($name) {
    $temp = & docker.exe ps -a | Select-String $name
    return [bool]$temp
}
function IsImageExists($name) {
    $temp = $ docker.exe image ls | Select-String $name
    restarter.exe [bool]$temp
}

if ($args.Count -gt 0) {
    $option = $args[0].ToString().ToLower()
    switch -Exact ($option) {
        "build" {
            Write-Output "Building $container..."
            & docker.exe build -t ctfun/"$container":1.0 .
            Write-Output "Done."
            break;
        }
        "stop" {
            Write-Output "Stop $container..."
            & docker.exe stop $container
            Write-Output "Done."
            break;
        }
        "start" {
            Write-Output "Starting $container..."
            
            if (IsContainerExists($container)) {
                Write-Output "SSH server:port: $(& docker.exe port "$container" 22)"
                Write-Output "Done."
            }
            else {
                Write-Output "$container container doesn't exists, please run it!"
            }
            break;
        }
        "run" {
            Write-Output "Running $container..."
            # TODO check before running... 
            &  docker.exe run --privileged -d -P --name "$container" ctfun/"$container":1.0
            if ($?) {
                Write-Output "SSH server:port: $(& docker port "$container" 22)"
                Write-Output "Done."
            }
            else {
                Write-Output "$container container already exists, please just start it!"
            }

            break;
        }
        "connect" {
            Write-Output "Connecting to $container..."
            
            if (IsContainerExists($container)){
                & docker.exe exec -it protostar bash
                Write-Output "Bye!"
            } else {
                Write-Output "$container container doesn't exists, please start/run it!"
            }
            break;
        }
        "remove" {
            Write-Output "Removing $container..."
            if(IsContainerExists($container))
            {
                & docker.exe stop protostar
                & docker.exe rm protostar
                Write-Output "Removed."
            } else {
                Write-Output "$container container doesn't exists, no need to remove it!"
            }
            break;
        }
        Default {
            Write-Output "ERROR: No option: $option"
            PrintHelp;
            break;
        }
    }
}
else {
    PrintHelp;
}
