#!/bin/bash

# Delete a conda env based on the current directory
# Assumes you have $MY_CONDA_ENVS set as an env variable

env_name="$MY_CONDA_ENVS/${PWD##*/}"

# Some spinner logic to show it's working
rm -rf $env_name &
PID=$!
spin[0]="-"
spin[1]="\\"
spin[2]="|"
spin[3]="/"

echo -n "	Deleting environment at: $env_name...	${spin[0]}"
while [ -d /proc/$PID ]
do
  for i in "${spin[@]}"
  do
        echo -ne "\b$i"
        sleep 0.1
  done
done
echo
echo "	DONE"
