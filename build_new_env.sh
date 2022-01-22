#!/bin/bash
# Purpose: Creates a conda env for the current repo
# Assumptions:
    # Having $MY_CONDA_ENVS set (export in .bashrc/.zshrc) as the location for keeping conda environments

# prep conda
eval "$(conda shell.bash hook)"
conda deactivate

# prep environment path
export CONDA_ENV_NAME=${PWD##*/}
export CONDA_ENV_PATH=${MY_CONDA_ENVS}/${CONDA_ENV_NAME}
echo $CONDA_ENV_PATH

# make environment
make build_env

# activate env
conda activate ${CONDA_ENV_PATH}

# install
# make install
