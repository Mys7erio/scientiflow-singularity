#!/bin/bash

eval "$(micromamba shell hook -s posix)"
micromamba activate pyenv_general

PATH=/opt/micromamba/envs/pyenv_general/bin:${PATH}
exec "$@" 