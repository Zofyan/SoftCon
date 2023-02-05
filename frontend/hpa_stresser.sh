#!/bin/bash
# Stress program for testing the horizontal pod scaling, by creating background tasks 
# which send wget requests to the frontendapp services 

# Run with bash ./hpa_stresser.sh

# Wait until program is done (3 mins) or exit using Ctrl-C

run_time_secs=180
num_stressers=60
url="https://best-forum.com/"

test_fnc () {
	while sleep 0.01; do wget $url -q -O - --no-check-certificate > /dev/null; done
}

arrVar=()
stress_service () {
	for i in `seq 1 $num_stressers`
	do 
		test_fnc &
		arrVar[$i]=$!
	done
}

kill_stressers () {
	for k in ${arrVar[@]}
	do 
		kill -9 $k
	done
}

run() {
	stress_service
	sleep $run_time_secs
	kill_stressers
}

run
  
