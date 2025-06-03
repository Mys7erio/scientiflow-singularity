#!/bin/bash

eval "$(micromamba shell hook -s posix)"
micromamba activate pyenv_general

exec "$@" 