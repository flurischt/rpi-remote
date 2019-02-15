#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

pushd "$(dirname "$0")"

pipenv install --skip-lock
pipenv run python ./main.py

popd
