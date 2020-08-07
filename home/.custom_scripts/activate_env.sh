#!/bin/bash

if [ $# = 0 ]; then
  ENV_NAME=$(ls $HOME/.local/share/virtualenvs/ | grep $BASE_ENV)
elif [ $# = 1 ]; then
  ENV_NAME=$(ls $HOME/.local/share/virtualenvs/ | grep $1)
else
  echo "Error: too many arguments"
fi

if [ $# -le 1 ]; then
  bash --init-file <(echo "source $HOME/.bashrc;source $HOME/.local/share/virtualenvs/$ENV_NAME/bin/activate; source $AIXBRAIN_PRJ_ROOT/.env")
fi
